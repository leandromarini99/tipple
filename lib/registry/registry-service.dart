import 'registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Registry>> fetchRegistry() async {
  var url = Uri.http('10.0.2.2:8990', 'users');

  final response = await http.get(url);
  print(response.body);
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    updateUserToJson('ab24cb73-cdbb-4ac0-94bb-23cdb3ebe628');
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
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users');
  http.Response response =
      await http.post(url, body: encodedBody, headers: header);
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
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users/$id');
  http.Response response =
      await http.delete(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

deleteUserFromJson(String id) {
  // Map Key/Value für Users
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
Future<Registry> fetchUserRegistry(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'users/$id');

  final response = await http.get(url);
  print(response.body);
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
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(users);
  print(encodedBody);
  var url = Uri.http('10.0.2.2:8990', 'users/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

updateUserToJson(String id) {
  // Future<Registry> jsonUser = fetchUserRegistry(id);
  // Registry updateRegistry =  fetchUserRegistry(id) as Registry;

  Map<String, dynamic> updateMap = Map<String, dynamic>();
  Map<String, dynamic> address = Map<String, dynamic>();
  updateMap['id'] = id;
  updateMap['firstName'] = 'Leandro';
  updateMap['lastName'] = 'Marini';
  updateMap['gender'] = 'M';
  updateMap['email'] = 'leandro@tipple';
  updateMap['password'] = 'address';
  updateMap['address'] = address;

  //Map Key/Value List für Users.Address
  address['town'] = '.town';
  address['zipCode'] = 'zipCode';
  address['street'] = 'street';
  address['houseNumber'] = 'houseNumber';

  // löschen des Users
  updateUser(updateMap, id);
}
// E
