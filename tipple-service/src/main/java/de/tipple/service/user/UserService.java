package de.tipple.service.user;

import de.tipple.model.user.User;
import de.tipple.repository.user.UserRepository;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@Service
public class UserService {

  private final UserRepository userRepository;


  public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }


  public Flux<User> getAll() {
    return userRepository.findAll();
  }

  public Mono<User> get(String id) {
    return userRepository.findById(id);
  }

  public Mono<User> update(String id, User user) {
    user.setId(id);
    return userRepository.findById(id)
        .map(u -> new User(user))
        .flatMap(userRepository::save);
  }

  public Mono<User> delete(String id) {
    return userRepository.findById(id)
        .flatMap(user -> userRepository.deleteById(user.getId()).thenReturn(user));
  }

  public Mono<User> create(User user) {
    user.setId(UUID.randomUUID().toString());
    return userRepository.save(user);
  }

}

