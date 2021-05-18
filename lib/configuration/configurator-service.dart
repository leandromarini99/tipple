import 'ingredient-configurator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Configuration>> fetchConfigurations() async {
  var url = Uri.http('10.0.2.2:8990', 'configurations');

  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    //deleteIngredientsFromJson('1d16a5d3-5543-4d01-ac8a-64431cad5b7b');
    postConfigurationToJson(
        '6379eac9-fe73-40cf-83fc-14b1d1fda14a',
        DateTime.now(),
        true,
        false,
        '844fda1c-3a94-42e5-9555-469b336f21b4',
        '',
        2.43);
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
  var url = Uri.http('10.0.2.2:8990', 'configuration');
  http.Response response =
      await http.post(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

postConfigurationToJson(String userId, DateTime date, bool share, bool cart,
    String id, String name, double price) {
  // Map Key/Value für Users
  Map<String, dynamic> configJson = Map<String, dynamic>();
  configJson['userId'] = userId;
  configJson['date'] = date;
  configJson['share'] = share;
  configJson['cart'] = cart;
  configJson['ingredients'] = createIngredient(id, name, price);

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
