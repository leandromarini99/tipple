package de.tipple.repository;

import de.tipple.model.Configuration;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

@EnableReactiveMongoRepositories
public interface ConfigurationRepository extends ReactiveCrudRepository<Configuration, String> {
}
