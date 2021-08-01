import 'registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 const  Map<String, String> HEADER = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};


Future<List<Registry>> fetchAllUsers() async {
  var url = Uri.http('10.0.2.2:8990', 'users');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((user) => Registry.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to laod Users');
  }
}

// Erstelle User in die Userdatenbank. loclhost:8990/users
// A
createUser(Map<String, dynamic> users) async {

  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users');
  http.Response response =
      await http.post(url, body: encodedBody, headers: HEADER);
  print(response.statusCode);
}

postUserToJson(
    String firstName,
    String lastName,
    String gender,
    String email,
    String password,
    String town,
    int zipCode,
    String street,
    String houseNumber) {
  // Map Key/Value für Users
  Map<String, dynamic> json = Map<String, dynamic>();
  json['firstName'] = firstName;
  json['lastName'] = lastName;
  json['gender'] = gender;
  json['email'] = email;
  json['password'] = password;
  //Map Key/Value List für Users.Address
  Map<String, dynamic> address = Map<String, dynamic>();
  json['address'] = address;
  address['town'] = town;
  address['zipCode'] = zipCode;
  address['street'] = street;
  address['houseNumber'] = houseNumber;

  // erstellen des Users
  createUser(json);
}
// E

// Lösche User aus der Userdatenbank localhost:8990/users/{id}
// A
deleteUser(Map<String, dynamic> users, String id) async {

  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users/$id');
  http.Response response =
      await http.delete(url, body: null, headers: HEADER);
  print(response.statusCode);
}

deleteUserFromJson(String id) {
  // Map Key/Value für Users
  Map<String, dynamic> json = Map<String, dynamic>();
  json['firstName'] = '';
  json['lastName'] = '';
  json['gender'] = '';
  json['email'] = '';
  json['password'] = '';
  //Map Key/Value List für Users.Address
  Map<String, dynamic> address = Map<String, dynamic>();
  json['address'] = address;
  address['town'] = '';
  address['zipCode'] = '';
  address['street'] = '';
  address['houseNumber'] = '';

  // löschen des Users
  deleteUser(json, id);
}
// E

// Get User from localhost:8990/users/{id}
//A
Future<Registry> fetchUserById( String id) async {
  var url = Uri.http('10.0.2.2:8990', 'users/$id');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Registry.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Users');
  }
}
// E

// Update User aus der Userdatenbank localhost:8990/users/{id}
// A
updateUser(Map<String, dynamic> users, String id) async {

  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: HEADER);
  print(response.statusCode);
}
// E

 Future<int> checkEmailAvailability(String email) async {
  var url = Uri.http('10.0.2.2:8990', 'users/check/$email');

  final response = await http.get(url);
  return response.statusCode;
}
