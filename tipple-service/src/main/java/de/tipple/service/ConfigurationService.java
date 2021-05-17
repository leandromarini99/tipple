package de.tipple.service;

import de.tipple.model.Configuration;
import de.tipple.model.Ingredient;
import de.tipple.repository.ConfigurationRepository;
import de.tipple.repository.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class ConfigurationService  {

  private final ConfigurationRepository configRepo;
  @Autowired
  private  IngredientRepository inRepo;


  public ConfigurationService(ConfigurationRepository configRepo) {
    this.configRepo = configRepo;
  }

  public Flux<Configuration> getPublicConfigurations() {
    return configRepo.findAll().filter(Configuration::isShare);
  }

  public Mono<Configuration> getConfigurationsById(String configId) {
    return configRepo.findById(configId);
  }

  public Mono<Configuration> update(String id , Configuration configuration) {
    return configRepo.findById(id)
        .map(conf-> {
          configuration.setId(conf.getId());
          return new Configuration(configuration);
        })
        .flatMap(configRepo::save);
  }

  public Mono<Configuration> delete(String id) {
    return configRepo.findById(id)
        .flatMap(conf-> configRepo.deleteById(conf.getId()).thenReturn(conf));
  }

  public Mono<Configuration> create(Configuration configuration) {
    var config = new Configuration(UUID.randomUUID().toString(),
        configuration.getUserId(), LocalDateTime.now(), configuration.isShare(),
        configuration.isCart(), getIngredientsAdditionalInfo(configuration.getIngredients()));

    return configRepo.save(config);
  }

  public Flux<Configuration> getConfigsByUser(String userID) {
    return configRepo.findAll()
        .filter(u->u.getUserId().equals(userID));
  }

  public List<Ingredient> getIngredientsAdditionalInfo(List<Ingredient> ingredients) {
     List<Ingredient> ingredientList = Collections.synchronizedList(new ArrayList<>());

     ingredients.forEach(ingredient -> {
       Ingredient ingre =inRepo
           .findById(ingredient.getId()).toProcessor().block();
       assert ingre != null;
       ingredientList.add(
           new Ingredient(ingre.getId(),ingre.getName(), ingre.getPrice())
       );

     });
     return ingredientList;
  }

  public Flux<Configuration> getCarts() {
    return configRepo.findAll().filter(Configuration::isCart);
  }

  public Flux<Configuration> getCartByUser(String userId) {
    return configRepo.findAll()
        .filter(user-> user.getUserId().equals(userId)&&user.isCart());
  }

}
