package de.tipple.repository;

import de.tipple.model.Ingredient;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

@EnableReactiveMongoRepositories
public interface IngredientRepository extends ReactiveCrudRepository<Ingredient, String> {
}
