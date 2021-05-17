package de.tipple.controller;

import de.tipple.model.User;
import de.tipple.service.UserService;
import org.reactivestreams.Publisher;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;

@Component
public class UserHTTPController {

  private final UserService userService;
  private static final MediaType jSONMediaType = MediaType.APPLICATION_JSON;

  public UserHTTPController(UserService userService) {
    this.userService = userService;
  }
  public Mono<ServerResponse> getById(ServerRequest request) {
    return defaultReadResponse(userService
        .getUserById(getIdFromPathVariable(request)));
  }
  public Mono<ServerResponse> getByEmail(ServerRequest request) {
    return defaultReadResponse(userService
        .findUserByEmail(getIdFromPathVariable(request)));
  }
  public Mono<ServerResponse> validate(ServerRequest request) {
    String email = getIdFromPathVariable(request);
    return Mono.from(userService.findUserByEmail(email)
        .flatMap(user -> ServerResponse.status(409)
            .body(Mono.just(email+" exists already"),String.class))
        .switchIfEmpty(ServerResponse.ok().body(Mono.just(email+" does not exist"),String.class)));
  }

  public Mono<ServerResponse> getUsers(ServerRequest request) {
    return ServerResponse.ok()
            .contentType(jSONMediaType)
            .body(Flux.from(userService.getUsers()), User.class);
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
   return defaultReadResponse(userService
       .delete(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById( ServerRequest request) {
    Flux<User> userFlux = request.bodyToFlux(User.class)
        .flatMap(user -> userService
            .update(getIdFromPathVariable(request), user));
    return defaultReadResponse(userFlux);
  }

  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<User> userFlux = request.bodyToFlux(User.class)
        .flatMap(userService::create);
    return defaultWriteResponse(userFlux);
  }

  private  static Mono<ServerResponse> defaultWriteResponse(Publisher<User> users) {
    return Mono.from(users)
        .flatMap(user -> ServerResponse
            .created(URI.create("/users/"+ user.getId()))
            .contentType(jSONMediaType)
            .body(Mono.just(user), User.class));
  }

  private static Mono<ServerResponse> defaultReadResponse(Publisher<User> users) {
    return Mono.from(users)
        .flatMap(user ->
        ServerResponse.ok()
            .contentType(jSONMediaType)
            .body(Mono.just(user),User.class))
        .switchIfEmpty(ServerResponse.notFound()
            .build());
  }

  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }


}
