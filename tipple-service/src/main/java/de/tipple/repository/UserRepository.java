package de.tipple.repository;

import de.tipple.model.User;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

@EnableReactiveMongoRepositories
public interface UserRepository extends ReactiveCrudRepository<User, String> {
}
