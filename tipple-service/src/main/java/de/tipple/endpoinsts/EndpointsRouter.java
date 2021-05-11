package de.tipple.endpoinsts;

import de.tipple.controller.configuration.ConfigurationHTTPController;
import de.tipple.controller.ingredient.IngredientHTTPController;
import de.tipple.controller.user.UserHTTPController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.reactive.function.server.ServerResponse;

@Configuration
public class EndpointsRouter {

  private static final String INGREDIENTS = "/ingredients";
  private static final String ID = "/{id}";
  private static final String USERS = "/users";
  private static final String CONFIGS = "/configurations";

  @Autowired
  IngredientHTTPController ingredientHandler;
  @Autowired
  UserHTTPController userHandler;
  @Autowired
  ConfigurationHTTPController config;


  @Bean
  RouterFunction<ServerResponse> route() {
    return RouterFunctions.route().GET(INGREDIENTS, ingredientHandler::getIngredients)
        .POST(INGREDIENTS, ingredientHandler::create)
        .GET(INGREDIENTS +ID, ingredientHandler::getById)
        .DELETE(INGREDIENTS +ID, ingredientHandler::deleteById)
        .PUT(INGREDIENTS +ID, ingredientHandler::updateById)

        .POST(USERS, userHandler::create)
        .GET(USERS, userHandler::getAll)
        .GET(USERS+ID, userHandler::getById)
        .DELETE(USERS+ID, userHandler::deleteById)
        .PUT(USERS+ID, userHandler::updateById)

        .POST(CONFIGS, config::create)
        .GET(CONFIGS, config::getPublicConfigurations)
        .GET(CONFIGS+"/carts", config::getCarts)
        .GET(CONFIGS+"/carts"+ID, config::getCartByUser)
        .GET(CONFIGS+"/user"+ID, config::getAllConfigurationsByUserId)
        .GET(CONFIGS+ID, config::getById)
        .DELETE(CONFIGS+ID, config::deleteById)
        .PUT(CONFIGS+ID, config::updateById)

        .build();
  }



 }
