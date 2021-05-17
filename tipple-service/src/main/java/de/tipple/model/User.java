package de.tipple.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class User {
  @Id
  private String id;
  private String firstName;
  private String lastName;
  private String gender;

  private String email;
  private String password;

  private Address address;

  public User() {

  }
  public User(String id, String firstName, String lastName,
              String gender, String email, String password , Address addresses) {

    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.gender = gender;
    this.email = email;
    this.password = password;
    this.address = addresses;
  }

  public User(User user) {
   this(user.getId(), user.getFirstName(), user.getLastName(), user.getGender(),
       user.getEmail(), user.getPassword(),user.getAddress());
  }


  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getFirstName() {
    return firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public String getGender() {
    return gender;
  }

  public String getEmail() {
    return email;
  }

  public String getPassword() {
    return password;
  }

  public Address getAddress() {
    return address;
  }

}
