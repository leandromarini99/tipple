package de.tipple.controller.ingredient;

import de.tipple.model.ingredient.Ingredient;
import de.tipple.service.ingredient.IngredientService;
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
    return defaultReadResponse(ingredientService.getIngredients());
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
    return defaultReadResponse(ingredientService.getIngredientById(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById(ServerRequest request) {
    Flux<Ingredient> ingredientFlux = request.bodyToFlux(Ingredient.class)
        .flatMap(ingredient -> ingredientService.update(getIdFromPathVariable(request),ingredient));
    return defaultReadResponse(ingredientFlux);
  }
  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<Ingredient> ingredientFlux = request.bodyToFlux(Ingredient.class)
        // beide sind gleich
//        .flatMap(ingredientService::create);
        .flatMap(ingredient -> ingredientService.create(ingredient));
    return defaultReadResponse(ingredientFlux);
  }
  private static Mono<ServerResponse> defaultWriteResponse(Publisher<Ingredient> ingredients) {
      return Mono.from(ingredients)
          .flatMap(ingredient -> ServerResponse.created(URI.create("/ingredients/"+ingredient.getId()))
          .contentType(jSONMediaType).build());
  }
  private static Mono<ServerResponse> defaultReadResponse(Publisher<Ingredient> ingredients) {
    return ServerResponse.ok()
        .contentType(jSONMediaType)
        .body(ingredients, Ingredient.class);
  }
  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }
}
