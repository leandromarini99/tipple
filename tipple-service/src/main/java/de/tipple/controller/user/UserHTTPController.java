package de.tipple.controller.user;

import de.tipple.model.user.User;
import de.tipple.service.user.UserService;
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
    return defaultReadResponse(userService.get(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> getAll(ServerRequest request) {
    return defaultReadResponse(userService.getAll());
  }

  public Mono<ServerResponse> deleteById(ServerRequest request) {
    return defaultReadResponse(userService.delete(getIdFromPathVariable(request)));
  }

  public Mono<ServerResponse> updateById( ServerRequest request) {
    Flux<User> userFlux = request.bodyToFlux(User.class)
        .flatMap(user -> userService.update(getIdFromPathVariable(request), user));
    return defaultReadResponse(userFlux);
  }

  public Mono<ServerResponse> create(ServerRequest request) {
    Flux<User> flux = request.bodyToFlux(User.class)
        .flatMap(userService::create);
    return defaultWriteResponse(flux);
  }

  private  static Mono<ServerResponse> defaultWriteResponse(Publisher<User> users) {
    return Mono.from(users)
        .flatMap(user -> ServerResponse.created(URI.create("/users/"+ user.getId()))
            .contentType(jSONMediaType)
            .build());
  }

  private static Mono<ServerResponse> defaultReadResponse(Publisher<User> users) {
    return ServerResponse
        .ok()
        .contentType(jSONMediaType)
        .body(users, User.class);
  }

  private static String getIdFromPathVariable(ServerRequest request) {
    return request.pathVariable("id");
  }


}
