package de.tipple.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;
@Document
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Configuration {
  @Id
  private String id;
  private String userId;
  private LocalDateTime date;
  private boolean share;
  private boolean cart;
  @JsonInclude(JsonInclude.Include.NON_NULL)
  private List<Ingredient> ingredients;
  public Configuration() {
  }

  public Configuration(String id, String userId, LocalDateTime date,
                       boolean share, boolean chart, List<Ingredient> ingredientList) {
    this.id = id;
    this.userId = userId;
    this.date = date;
    this.share = share;
    this.cart = chart;
    this.ingredients = ingredientList;
  }
  public Configuration(Configuration config) {
    this(config.id, config.userId, config.getDate(),
        config.isShare(), config.isCart(), config.getIngredients());
  }

  public boolean isCart() {
    return cart;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getUserId() {
    return userId;
  }

  public boolean isShare() {
    return share;
  }

  public List<Ingredient> getIngredients() {
    return ingredients;
  }

  public LocalDateTime getDate() {
    return date;
  }
}
