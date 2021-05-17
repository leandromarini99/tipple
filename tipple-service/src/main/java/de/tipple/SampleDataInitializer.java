package de.tipple;

import de.tipple.model.Configuration;
import de.tipple.model.Ingredient;
import de.tipple.model.Address;
import de.tipple.model.User;
import de.tipple.repository.ConfigurationRepository;
import de.tipple.repository.IngredientRepository;
import de.tipple.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Flux;

import java.time.LocalDateTime;
import java.util.*;

@Component
@org.springframework.context.annotation.Profile("Development")
public class SampleDataInitializer implements ApplicationListener<ApplicationReadyEvent> {
  @Autowired
  public final UserRepository repository;
  @Autowired
  public final IngredientRepository ingredientRepository;
  @Autowired final ConfigurationRepository configurationRepository;
  private final String inID1;
  private final String inID2;
  private final String inID3;
  private final String inID4;

  public SampleDataInitializer(UserRepository repository,
                               IngredientRepository ingredientRepository,
                               ConfigurationRepository configurationRepository) {
    this.repository = repository;
    this.ingredientRepository = ingredientRepository;
    this.configurationRepository = configurationRepository;

    inID1 = UUID.randomUUID().toString();
    inID2 = UUID.randomUUID().toString();
    inID3 = UUID.randomUUID().toString();
    inID4 = UUID.randomUUID().toString();

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
        Arrays.asList( new User(UUID.randomUUID().toString(), "John Luca", "Maack",
                "M","john@tipple.com","12345",
                new Address("Berlin", 22304,"Main Str.","43C")),

            new User(UUID.randomUUID().toString(), "Toni", "Fiebiger",
                "M","toni@tipple.com","12345",
                new Address("Berlin", 22304,"Schmidt Str.","322")),

            new User(UUID.randomUUID().toString(), "Lars", "Newrzella",
                "M","lars@tipple.com","12345",
                new Address("Hamburg", 22304,"Mueller Str.","343")),

            new User(UUID.randomUUID().toString(), "Leandro", "Marine",
            "M","leandro@tipple.com","12345",
            new Address("Hamburg", 22304,"Alton Str.","89")),

            new User(UUID.randomUUID().toString(), "Mohamed", "Omar Ahmed",
            "M","mohamed@tipple.com","12345",
            new Address("Lübeck", 22304,"Mai Str.","56A"))
        )
    );
  }

  private List<Ingredient> addIngredients() {
    return new ArrayList<> (
        Arrays.asList(new Ingredient(inID1,"Apfel","www.apfel.de", 2.43),
            new Ingredient(inID2,"Orange","www.orange.de", 1.43),
            new Ingredient(inID3,"Banane","www.banane.de", 0.99),
            new Ingredient(inID4,"Mango","www.mango.de", 2.99),
            new Ingredient(UUID.randomUUID().toString(),"Melon","www.melon.de", 3.43))
        );
  }

  private List<Configuration> addConfigs() {
    return new ArrayList<>(Arrays.asList(
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), true, true,
            Arrays.asList(new Ingredient(inID2,"Orange",1.43),
            new Ingredient(inID3,"Banane",0.99),
            new Ingredient(inID1,"Apfel",2.43)
            )
        ),
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), false, false,
            Arrays.asList(new Ingredient(inID1,"Orange",0.99),
            new Ingredient(inID4,"Mongo",2.99),
            new Ingredient(inID1,"Apfel",2.43)
            )
        ),  new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), false, false,
            Arrays.asList(new Ingredient(inID1,"Orange",1.43),
                new Ingredient(inID1,"Apfel",2.43),
                new Ingredient(inID4,"Mongo",2.99)
            )
        ),
        new Configuration(UUID.randomUUID().toString(), UUID.randomUUID().toString(),
            LocalDateTime.now(), true, false,
            Arrays.asList(new Ingredient(inID2,"Orange",1.43),
            new Ingredient(inID4,"Mongo",2.99),
            new Ingredient(inID1,"Apfel",2.43)
            )
        )
    ));
  }
}
