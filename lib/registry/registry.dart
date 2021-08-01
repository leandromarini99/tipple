class Registry {
   Registry(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.password,
      this.address});

   String id;
   String firstName;
   String lastName;
   String gender;
   String email;
   String password;
   Address address;

  factory Registry.fromJson(Map<String, dynamic> json) {
    return Registry(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        email: json['email'],
        password: json['password'],
        address: Address.fromJson(json['address']));
  }
}

class Address {
   Address({ this.street, this.houseNumber, this.zipCode,this.town});

   String town;
   int zipCode;
   String street;
   String houseNumber;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        street: json['street'],
        houseNumber: json['houseNumber'],
        zipCode: json['zipCode'],
        town: json['town']);
  }
}
