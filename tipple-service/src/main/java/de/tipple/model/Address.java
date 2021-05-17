package de.tipple.model;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Address {
  private final String town;
  private final int zipCode;
  private final String street;
  private final String houseNumber;

  public Address(String town, int zipCode, String street, String houseNumber) {
    this.town = town;
    this.zipCode = zipCode;
    this.street = street;
    this.houseNumber = houseNumber;
  }

  public String getTown() {
    return town;
  }

  public int getZipCode() {
    return zipCode;
  }

  public String getStreet() {
    return street;
  }

  public String getHouseNumber() {
    return houseNumber;
  }
}
