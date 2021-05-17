package de.tipple.controller;

import de.tipple.model.Ingredient;
import de.tipple.service.IngredientService;
import org.reactivestreams.Publisher;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;

@Component
public class IngredientHTTPController {
  private final IngredientService ingredientService;
  private static final MediaType jSONMediaType = MediaType.APPLICATION_JSON;

  public IngredientHTTPController(IngredientService ingredientService) {
    this.ingredientService = ingredientService;
  }

  public Mono<ServerResponse> getById(ServerRequest request) {
    return defaultReadResponse(ingredientService
        .getIngredientById(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> getIngredients(ServerRequest request) {
    return ServerResponse.ok()
        .contentType(jSONMediaType)
        .body(Flux.from(ingredientService.getIngredients()),Ingredient.class);
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
    return defaultReadResponse(ingredientService.delete(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById(ServerRequest request) {
    Flux<Ingredient> ingredientFlux = request.bodyToFlux(Ingredient.class)
        .flatMap(ingredient -> ingredientService
            .update(getIdFromPathVariable(request),ingredient));
    return defaultReadResponse(ingredientFlux);
  }

  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<Ingredient> ingredientFlux = request.bodyToFlux(Ingredient.class)
        .flatMap(ingredientService::create);
    return defaultWriteResponse(ingredientFlux);
  }

  private static Mono<ServerResponse> defaultWriteResponse(Publisher<Ingredient> ingredients) {
      return Mono.from(ingredients)
          .flatMap(ingredient -> ServerResponse
              .created(URI.create("/ingredients/"+ingredient.getId()))
          .contentType(jSONMediaType)
              .body(Mono.just(ingredient), Ingredient.class));
  }

  private static Mono<ServerResponse> defaultReadResponse(Publisher<Ingredient> ingredients) {
    return Mono.from(ingredients).flatMap(ingredient ->
        ServerResponse.ok()
            .contentType(jSONMediaType)
            .body(Mono.just(ingredient), Ingredient.class))
        .switchIfEmpty(ServerResponse.notFound().build());
  }

  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }

}
