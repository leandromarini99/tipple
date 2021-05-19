import 'ingredient-configurator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Configuration>> fetchConfigurations() async {
  var url = Uri.http('10.0.2.2:8990', 'configurations');

  final response = await http.get(url);
  // print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    fetchConfigurationsInCartByUserId('31ad0101-efc2-4b4d-820d-061c0eabdfd6');
    // deleteConfiguration('42120a5f-e9e1-49aa-b396-3d2126cbf0db');
    // updateConfigurationToJson(
    //     '6379eac9-fe73-40cf-83fc-14b1d1fda14a',
    //     DateTime.now(),
    //     true,
    //     false,
    //     'e34ed4ad-1227-4070-8254-cf4cd012c1bb',
    //     'AMK',
    //     0.00);
    /*postConfigurationToJson(
        '6379eac9-fe73-40cf-83fc-14b1d1fda14a',
        DateTime.now(),
        true,
        false,
        '844fda1c-3a94-42e5-9555-469b336f21b4',
        '',
        2.43);*/
    return (responseJson as List)
        .map((config) => Configuration.fromJson(config))
        .toList();
  } else {
    throw Exception('Failed to laod configurations');
  }
}

/*-----------------------Post Configuration---------------------------*/
createConfiguration(Map<String, dynamic> configurations) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(configurations);
  var url = Uri.http('10.0.2.2:8990', 'configurations');
  http.Response response =
      await http.post(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

postConfigurationToJson(String userId, DateTime date, bool share, bool cart,
    String id, String name, double price) {
  // Map Key/Value für Users
  Map<String, dynamic> configJson = Map<String, dynamic>();
  configJson['userId'] = userId;
  configJson['date'] = date.toIso8601String();
  configJson['share'] = share;
  configJson['cart'] = cart;
  configJson['ingredients'] = [createIngredient(id, name, price)];

  // erstellen des Users
  createConfiguration(configJson);
}

Map<String, dynamic> createIngredient(String id, String name, double price) {
  Map<String, dynamic> ingredientJson = Map<String, dynamic>();
  ingredientJson['id'] = id;
  ingredientJson['name'] = name;
  ingredientJson['price'] = price;
  return ingredientJson;
}

/* ---------------- Delete Configuration ---------------- */
deleteConfiguration(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/$id');
  http.Response response = await http.delete(url);
  print(response.statusCode);
}

/* ---------------- Put Configuration ---------------- */
updateConfiguration(Map<String, dynamic> configurations, String id) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(configurations);
  var url = Uri.http('10.0.2.2:8990', 'configurations/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

Map<String, dynamic> updateIngredientToJson(
    String id, String name, double price) {
  Map<String, dynamic> updateMap = Map<String, dynamic>();

  updateMap['id'] = id;
  updateMap['name'] = name;
  updateMap['price'] = price;
  return updateMap;

  // löschen des Users
  // updateConfiguration(updateMap, id);
}

updateConfigurationToJson(String userId, DateTime date, bool share, bool cart,
    String id, String name, double price) {
  // Map Key/Value für Users
  Map<String, dynamic> configJson = Map<String, dynamic>();
  configJson['userId'] = userId;
  configJson['date'] = date.toIso8601String();
  configJson['share'] = share;
  configJson['cart'] = cart;
  configJson['ingredients'] = [updateIngredientToJson(id, name, price)];

  // erstellen des Users
  updateConfiguration(configJson, id);
}

Future<List<Configuration>> fetchConfigurationsByUserId(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/user/' + id);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.body);
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((config) => Configuration.fromJson(config))
        .toList();
  } else {
    throw Exception('Failed to laod configurations');
  }
}

Future<List<Configuration>> fetchConfigurationsInCartByUserId(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/carts/' + id);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.body);
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((config) => Configuration.fromJson(config))
        .toList();
  } else {
    throw Exception('Failed to laod configurations');
  }
}
Future<Configuration> fetchConfigurationById(String id) async {
  var url = Uri.http('10.0.2.2:8990', 'configurations/' + id);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.body);
    var responseJson = json.decode(response.body);
    return 
         Configuration.fromJson(responseJson);
  } else {
    throw Exception('Failed to laod configurations');
  }
}
