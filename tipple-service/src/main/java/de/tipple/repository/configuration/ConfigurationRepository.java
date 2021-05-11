package de.tipple.repository.configuration;

import de.tipple.model.configuration.Configuration;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

@EnableReactiveMongoRepositories
public interface ConfigurationRepository extends ReactiveCrudRepository<Configuration, String> {
}
