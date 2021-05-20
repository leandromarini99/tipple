import 'package:tipple_app/registry/app-signIn.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'package:tipple_app/registry/registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// A
updateUser(Map<String, dynamic> users, dynamic id) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(users);
  var url = Uri.http('10.0.2.2:8990', 'users/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

updateUserPasswordToJson(AppSignIn id, String password) async {
  Future<Registry> jsonUser = fetchUserRegistry(id);
  Registry updateRegistry = await jsonUser;
  Map<String, dynamic> updateMap = Map<String, dynamic>();
  updateMap['id'] = id;
  updateMap['firstName'] = updateRegistry.firstName;
  updateMap['lastName'] = updateRegistry.lastName;
  updateMap['gender'] = updateRegistry.gender;
  updateMap['email'] = updateRegistry.email;
  updateMap['password'] = password;

  //Map Key/Value List für Users.Address
  Map<String, dynamic> address = Map<String, dynamic>();
  updateMap['address'] = address;
  address['town'] = updateRegistry.address.town;
  address['zipCode'] = updateRegistry.address.zipCode;
  address['street'] = updateRegistry.address.street;
  address['houseNumber'] = updateRegistry.address.houseNumber;

  // löschen des Users
  updateUser(updateMap, id);
}
// E
