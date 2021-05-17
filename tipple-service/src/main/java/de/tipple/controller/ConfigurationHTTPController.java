package de.tipple.controller;

import de.tipple.model.Configuration;

import de.tipple.service.ConfigurationService;

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
  public Mono<ServerResponse> getConfigurationsByUserId(ServerRequest request) {
    return defaultMultiReadResponse(configurationService
        .getConfigsByUser(getIdFromPathVariable(request)));
  }
  public Mono<ServerResponse> getPublicConfigurations(ServerRequest request) {
    return defaultMultiReadResponse(configurationService.getPublicConfigurations());
  }
  public Mono<ServerResponse> getCarts(ServerRequest request) {
    return defaultSingleReadResponse(configurationService.getCarts());
  }
  public Mono<ServerResponse> getCartByUser(ServerRequest request) {
    return defaultSingleReadResponse(configurationService
        .getCartByUser(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> getConfigurationById(ServerRequest request) {
    return defaultSingleReadResponse(configurationService
        .getConfigurationsById(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
    return defaultSingleReadResponse(configurationService
        .delete(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById( ServerRequest request) {
    Flux<Configuration> config = request.bodyToFlux(Configuration.class)
        .flatMap(conf -> configurationService.update(getIdFromPathVariable(request), conf));
    return defaultSingleReadResponse(config);
  }

  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<Configuration> flux = request.bodyToFlux(Configuration.class)
        .flatMap(configurationService::create);
    return defaultWriteResponse(flux);
  }

  private  static Mono<ServerResponse> defaultWriteResponse(Publisher<Configuration> configs) {
    return Mono.from(configs)
        .flatMap(config -> ServerResponse
            .created(URI.create("/configurations/"+ config.getId()))
        .contentType(jSONMediaType)
            .body(Mono.just(config), Configuration.class));
  }

  private static Mono<ServerResponse> defaultSingleReadResponse(Publisher<Configuration> configs) {
    return Mono.from(configs).flatMap(configuration ->
        ServerResponse.ok()
            .body(Mono.just(configuration),Configuration.class))
        .switchIfEmpty(ServerResponse.notFound().build());
  }
  private static Mono<ServerResponse> defaultMultiReadResponse(Publisher<Configuration> configs) {
    return Mono.from(configs)
        .flatMap(configuration ->
        ServerResponse.ok()
            .body(Flux.from(configs), Configuration.class))
        .switchIfEmpty(ServerResponse.notFound().build());
  }

  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }
}
