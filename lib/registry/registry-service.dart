import 'registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Registry>> fetchRegistry() async {
  var url = Uri.http('10.0.2.2:8990', 'users');

  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    toJason();
    return (responseJson as List)
        .map((user) => Registry.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to laod Users');
  }
}

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

toJason(/* textfeld1 */) {
  // Map Key/Value für Users
  Map<String, dynamic> json = Map<String, dynamic>();
  json['firstName'] = "textfeld1";
  json['lastName'] = "Ossborn";
  json['gender'] = "M";
  json['email'] = "ossborn@gmail.com";
  json['password'] = "ossborn123";
  //Map Key/Value List für Users.Address
  Map<String, dynamic> address = Map<String, dynamic>();
  json['address'] = address;
  address['town'] = 'Berlin';
  address['zipCode'] = 10117;
  address['street'] = "Heckerdamm";
  address['houseNumber'] = "27b";

  // erstellen des Users
  createUser(json);
}
