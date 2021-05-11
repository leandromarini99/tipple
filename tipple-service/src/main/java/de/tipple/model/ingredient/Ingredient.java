package de.tipple.model.ingredient;

import com.fasterxml.jackson.annotation.JsonInclude;
import de.tipple.model.user.Address;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Ingredient {
  @Id
  private String id;
  private String name;
  private String url;
  private Double price;

  public Ingredient() {
  }

  public Ingredient(String id, String name, String url, Double price) {
    this.id = id;
    this.name = name;
    this.url = url;
    this.price = price;
  }
  public Ingredient(String name, Double price) {
    this.name = name;
    this.price = price;
  }
  public Ingredient(Ingredient ingredient) {
    this(ingredient.getId(), ingredient.getName(), ingredient.getUrl(), ingredient.getPrice());
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public String getUrl() {
    return url;
  }

  public Double getPrice() {
    return price;
  }

}
