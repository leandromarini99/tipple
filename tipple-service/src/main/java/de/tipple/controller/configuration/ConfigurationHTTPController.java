package de.tipple.controller.configuration;

import de.tipple.model.configuration.Configuration;

import de.tipple.model.ingredient.Ingredient;
import de.tipple.service.configuration.ConfigurationService;

import org.reactivestreams.Publisher;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;

@Component
public class ConfigurationHTTPController {
  private final ConfigurationService configurationService;
  private static final MediaType jSONMediaType = MediaType.APPLICATION_JSON;

  public ConfigurationHTTPController(ConfigurationService configurationService) {
    this.configurationService = configurationService;
  }
  public Mono<ServerResponse> getAllConfigurationsByUserId(ServerRequest request) {
    return defaultReadResponse(configurationService.getConfigsByUser(getIdFromPathVariable(request)));
  }
  public Mono<ServerResponse> getPublicConfigurations(ServerRequest request) {
    return defaultReadResponse(configurationService.getPublicConfigurations());
  }
  public Mono<ServerResponse> getCarts(ServerRequest request) {
    return defaultReadResponse(configurationService.getCarts());
  }
  public Mono<ServerResponse> getCartByUser(ServerRequest request) {
    return defaultReadResponse(configurationService.getCartByUser(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> getById(ServerRequest request) {
    return defaultReadResponse(configurationService.getConfigurationsById(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
    return defaultReadResponse(configurationService.delete(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById( ServerRequest request) {
    Flux<Configuration> config = request.bodyToFlux(Configuration.class)
        .flatMap(conf -> configurationService.update(getIdFromPathVariable(request), conf));
    return defaultReadResponse(config);
  }

  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<Configuration> flux = request.bodyToFlux(Configuration.class)
        .flatMap(configurationService::create);
    return defaultWriteResponse(flux);
  }

  private  static Mono<ServerResponse> defaultWriteResponse(Publisher<Configuration> configs) {
    return Mono.from(configs)
        .flatMap(config -> ServerResponse.created(URI.create("/configurations/"+ config.getId()))
        .contentType(jSONMediaType)
            .body(configs, Configuration.class));
//        .build());
  }

  private static Mono<ServerResponse> defaultReadResponse(Publisher<Configuration> configs) {
    return ServerResponse
        .ok()
        .contentType(jSONMediaType)
        .body(configs, Configuration.class);
  }

  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }
}
