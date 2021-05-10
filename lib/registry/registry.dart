class Registry {
  const Registry(
      {this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.password,
      this.address});

  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String password;
  // final List<Address> address;
  final Address address;

  factory Registry.fromJson(Map<String, dynamic> json) {
    return Registry(
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        email: json['email'],
        password: json['password'],
 
        // address:
            // (json['address'] as List).map((e) => Address.fromJson(e)).toList()
            address: Address.fromJson(json['address'])
            );
  }
}

class Address {
  const Address({this.town, this.zipCode, this.street, this.houseNumber});

  final String town;
  final int zipCode;
  final String street;
  final String houseNumber;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        town: json['town'],
        zipCode: json['zipCode'],
        street: json['street'],
        houseNumber: json['houseNumber']);
  }

}

