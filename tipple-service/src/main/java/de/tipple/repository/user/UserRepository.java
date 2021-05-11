package de.tipple.repository.user;

import de.tipple.model.user.User;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

@EnableReactiveMongoRepositories
public interface UserRepository extends ReactiveCrudRepository<User, String> {
}
