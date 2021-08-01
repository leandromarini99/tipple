import 'package:tipple_app/ingredient/ingredient.dart';

import 'configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const Map<String, String> HEADER = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

/*-----------------------Post Configuration---------------------------*/
postConfiguration(Map<String, dynamic> configurations) async {
  var encodedBody = json.encode(configurations);
  var url = Uri.http('10.0.2.2:8990', 'configurations');
  http.Response response =
      await http.post(url, body: encodedBody, headers: HEADER);
  print(response.statusCode);
}

createConfiguration(String userId, bool cart, List<Ingredient> ingredients) {
  Map<String, dynamic> configJson = Map<String, dynamic>();
  configJson['userId'] = userId;
  configJson['date'] = DateTime.now().toIso8601String();
  configJson['share'] = false;
  configJson['cart'] = cart;
  configJson['ingredients'] = ingredients;

  postConfiguration(configJson);
}

/* ---------------- Delete Configuration ---------------- */
deleteConfiguration(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/$id');
  http.Response response = await http.delete(url);
  print(response.statusCode);
}

/* ---------------- Put Configuration ---------------- */
updateConfiguration(Map<String, dynamic> configurations, String id) async {
  var encodedBody = json.encode(configurations);
  var url = Uri.http('10.0.2.2:8990', 'configurations/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: HEADER);
  print(response.statusCode);
}

updateConfigurationToJson(Configuration config, bool share, bool cart) {
  // Map Key/Value für Users
  Map<String, dynamic> configJson = Map<String, dynamic>();
  configJson['userId'] = config.userId;
  configJson['date'] = config.date;
  configJson['share'] = share;
  configJson['cart'] = cart;
  configJson['ingredients'] = config.ingredient;

  // erstellen des Users
  updateConfiguration(configJson, config.id);
}

Future<List<Configuration>> requestConfigurations(Uri uri) async {
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.body);
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((config) => Configuration.fromJson(config))
        .toList();
  } else {
    throw Exception('Failed to load configurations');
  }
}

Future<List<Configuration>> fetchConfigurations() async {
  var url = Uri.http('10.0.2.2:8990', 'configurations');

  return requestConfigurations(url);
}

Future<List<Configuration>> fetchConfigurationsByUserId(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/user/' + id);
  return requestConfigurations(url);
}

Future<List<Configuration>> fetchConfigurationsInCartByUserId(String userId) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/carts/' + userId);
  return requestConfigurations(url);
}

Future<Configuration> fetchConfigurationById(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/' + id);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.body);
    var responseJson = json.decode(response.body);
    return Configuration.fromJson(responseJson);
  } else {
    throw Exception('Failed to load configurations');
  }
}
