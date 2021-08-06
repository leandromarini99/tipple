import 'package:tipple_app/registry/registry-service.dart';
import 'package:tipple_app/registry/registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// A
// updateUser(Map<String, dynamic> users, dynamic id) async {
//   const Map<String, String> header = {
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//   };
//   var encodedBody = json.encode(users);
//   var url = Uri.http('10.0.2.2:8990', 'users/$id');
//   http.Response response =
//       await http.put(url, body: encodedBody, headers: header);
//   print(response.statusCode);
// }

updateUserPasswordToJson(String id, String password) async {
  Future<Registry> jsonUser = fetchUserById(id);
  Registry registry = await jsonUser;
  Map<String, dynamic> updateMap = buildMap(registry);
  updateMap['password'] = password;
  // löschen des Users
  updateUser(updateMap, id);
}

updateUserEmailToJson(String id, String email) async {
  Future<Registry> jsonUser = fetchUserById(id);
  Registry registry = await jsonUser;
  Map<String, dynamic> updateMap = buildMap(registry);
  updateMap['email'] = email;
  // löschen des Users
  updateUser(updateMap, id);
}
// E

Map<String, dynamic>buildMap(Registry registry) {
  Map<String, dynamic> map = Map<String, dynamic>();
  map['id'] = registry.id;
  map['firstName'] = registry.firstName;
  map['lastName'] = registry.lastName;
  map['gender'] = registry.gender;
  map['email'] = registry.email;
  map['password'] = registry.password;

  //Map Key/Value List für Users.Address
  Map<String, dynamic> address = Map<String, dynamic>();
  map['address'] = address;
  address['town'] = registry.address.town;
  address['zipCode'] = registry.address.zipCode;
  address['street'] = registry.address.street;
  address['houseNumber'] = registry.address.houseNumber;
  return map;
}
