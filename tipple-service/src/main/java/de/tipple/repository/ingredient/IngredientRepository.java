package de.tipple.repository.ingredient;

import de.tipple.model.configuration.Configuration;
import de.tipple.model.ingredient.Ingredient;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

@EnableReactiveMongoRepositories
public interface IngredientRepository extends ReactiveCrudRepository<Ingredient, String> {
}
