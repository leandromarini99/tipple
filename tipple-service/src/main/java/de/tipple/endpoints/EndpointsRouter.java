package de.tipple.endpoints;

import de.tipple.controller.ConfigurationHTTPController;
import de.tipple.controller.IngredientHTTPController;
import de.tipple.controller.UserHTTPController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.reactive.function.server.ServerResponse;

@Configuration
public class EndpointsRouter {

  private static final String CONFIGS = "/configurations";
  private static final String INGREDIENTS = "/ingredients";
  private static final String USERS = "/users";
  private static final String ID = "/{id}";

  @Autowired
  IngredientHTTPController ingredientHandler;
  @Autowired
  UserHTTPController userHandler;
  @Autowired
  ConfigurationHTTPController config;


  @Bean
  RouterFunction<ServerResponse> route() {
    return RouterFunctions.route()

        .DELETE(INGREDIENTS +ID, ingredientHandler::deleteById)
        .GET(INGREDIENTS, ingredientHandler::getIngredients)
        .GET(INGREDIENTS +ID, ingredientHandler::getById)
        .POST(INGREDIENTS, ingredientHandler::create)
        .PUT(INGREDIENTS +ID, ingredientHandler::updateById)

        .DELETE(USERS+ID, userHandler::deleteById)
        .GET(USERS+ID, userHandler::getById)
        .GET(USERS+"/email"+ID, userHandler::getByEmail)
        .GET(USERS+"/check"+ID, userHandler::validate)
        .GET(USERS, userHandler::getUsers)
        .POST(USERS, userHandler::create)
        .PUT(USERS+ID, userHandler::updateById)

        .DELETE(CONFIGS+ID, config::deleteById)
        .GET(CONFIGS, config::getPublicConfigurations)
        .GET(CONFIGS+"/carts", config::getCarts)
        .GET(CONFIGS+"/carts"+ID, config::getCartByUser)
        .GET(CONFIGS+ID, config::getConfigurationById)
        .GET(CONFIGS+"/user"+ID, config::getConfigurationsByUserId)
        .POST(CONFIGS, config::create)
        .PUT(CONFIGS+ID, config::updateById)

        .build();
  }

 }
