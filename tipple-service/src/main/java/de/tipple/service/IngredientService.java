package de.tipple.service;

import de.tipple.model.Ingredient;
import de.tipple.repository.IngredientRepository;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@Service
public class IngredientService {

  private final IngredientRepository ingredientRepository;

  public IngredientService(IngredientRepository ingredientRepository) {
    this.ingredientRepository = ingredientRepository;
  }

  public Flux<Ingredient> getIngredients() {
    return ingredientRepository.findAll();
  }

  public Mono<Ingredient> getIngredientById(String id) {
    return ingredientRepository.findById(id);
  }

  public Mono<Ingredient> update(String id, Ingredient ingredient) {
    return ingredientRepository.findById(id)
        .map(ing -> {
          ingredient.setId(ing.getId());
         return new Ingredient(ingredient);
        })
        .flatMap(ingredientRepository::save);
  }

  public Mono<Ingredient> delete(String id) {
    return ingredientRepository.findById(id)
        .flatMap(ingredient -> ingredientRepository
            .deleteById(ingredient.getId())
        .thenReturn(ingredient));
  }

  public Mono<Ingredient> create(Ingredient ingredient) {
    ingredient.setId(UUID.randomUUID().toString());
    return ingredientRepository.save(ingredient);
  }


}
