package de.tipple.service;

import de.tipple.model.User;
import de.tipple.repository.UserRepository;
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

  public Flux<User> getUsers() {
    return userRepository.findAll();
  }

  public Mono<User> getUserById(String id) {
    return userRepository.findById(id);
  }

  public Mono<User> update(String id, User user) {
    return userRepository.findById(id)
        .map(u -> {
          user.setId(u.getId());
          return new User(user);
        })
        .flatMap(userRepository::save);
  }

  public Mono<User> delete(String id) {
    return userRepository.findById(id)
        .flatMap(user -> userRepository
            .deleteById(user.getId())
            .thenReturn(user));
  }

  public Mono<User> create(User user) {
    user.setId(UUID.randomUUID().toString());
    return userRepository.save(user);
  }

  public Flux<User> findUserByEmail(String email) {
  return userRepository.findAll()
        .filter(user -> user.getEmail().equals(email))
      .doOnNext(Mono::just);

  }

}

