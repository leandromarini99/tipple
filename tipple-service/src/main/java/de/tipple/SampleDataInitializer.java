package de.tipple;

import de.tipple.model.configuration.Configuration;
import de.tipple.model.ingredient.Ingredient;
import de.tipple.model.user.Address;
import de.tipple.model.user.User;
import de.tipple.repository.configuration.ConfigurationRepository;
import de.tipple.repository.ingredient.IngredientRepository;
import de.tipple.repository.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Flux;

import java.time.LocalDateTime;
import java.util.*;

@Component
@org.springframework.context.annotation.Profile("dev")
public class SampleDataInitializer implements ApplicationListener<ApplicationReadyEvent> {
  @Autowired
  public final UserRepository repository;
  @Autowired
  public final IngredientRepository ingredientRepository;
  @Autowired final ConfigurationRepository configurationRepository;

  public SampleDataInitializer(UserRepository repository,
                               IngredientRepository ingredientRepository, ConfigurationRepository configurationRepository) {
    this.repository = repository;

    this.ingredientRepository = ingredientRepository;
    this.configurationRepository = configurationRepository;
  }

  @Override
  public void onApplicationEvent(ApplicationReadyEvent event) {

    repository.deleteAll().thenMany(
        Flux
            .fromIterable(addUsers())
            .map(User::new)
            .flatMap(repository::save)
    ).thenMany(repository.findAll())
        .subscribe(user -> System.err.println("Saving User: "+ user.getId()));

    ingredientRepository.deleteAll().thenMany(
        Flux
            .fromIterable(addIngredients())
            .map(Ingredient::new)
            .flatMap(ingredientRepository::save)
    ).thenMany(ingredientRepository.findAll())
        .subscribe(ing -> System.err.println("Saving Ingredient: "+ ing.getId()));

    configurationRepository.deleteAll().thenMany(
        Flux
            .fromIterable(addConfigs())
            .map(Configuration::new)
            .flatMap(configurationRepository::save)
    ).thenMany(configurationRepository.findAll())
        .subscribe(conf -> System.err.println("Saving Configuration: "+ conf.getId()));


  }
  private List<User> addUsers() {
    return new ArrayList<>(
        Arrays.asList( new User(UUID.randomUUID().toString(), "John", "Maack",
                "M","john@tipple.com","12345",
                new Address("Berlin", 22304,"Main Str.","43C")),
            new User(UUID.randomUUID().toString(), "Toni", "Fieber",
                "M","toni@tipple.com","12345",
                new Address("Berlin", 22304,"Schmidt Str.","322")),
            new User(UUID.randomUUID().toString(), "Lars", "N.",
                "M","lars@tipple.com","12345",
                new Address("Hamburg", 22304,"Mueller Str.","343")),
            new User(UUID.randomUUID().toString(), "Leandro", "M.",
            "M","leandro@tipple.com","12345",
            new Address("Hamburg", 22304,"Alton Str.","89")))
    );
  }

  private List<Ingredient> addIngredients() {
    return new ArrayList<> (
        Arrays.asList(new Ingredient(UUID.randomUUID().toString(),"Apfel","www.apfel.de", 2.43),
            new Ingredient(UUID.randomUUID().toString(),"Orange","www.orange.de", 1.43),
            new Ingredient(UUID.randomUUID().toString(),"Melon","www.melon.de", 3.43))
        );
  }

  private List<Configuration> addConfigs() {
    return new ArrayList<>(Arrays.asList(
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), true, true, Arrays.asList(new Ingredient("Orange",0.99),
            new Ingredient("Mongo",2.23),
            new Ingredient("Apfel",1.23)
            )),
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), false, false, Arrays.asList(new Ingredient("Orange",0.99),
            new Ingredient("Mongo",2.23),
            new Ingredient("Apfel",1.23)
        )),
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), true, false, Arrays.asList(new Ingredient("Orange",0.99),
            new Ingredient("Mongo",2.23),
            new Ingredient("Apfel",1.23)
        ))
    ));
  }
}
