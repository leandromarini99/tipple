import 'ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Ingredient>> fetchIngredients() async {
  var url = Uri.http('10.0.2.2:8990', 'ingredients');

  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((ingre) => Ingredient.fromJson(ingre))
        .toList();
  } else {
    throw Exception('Failed to laod ingredients');
  }
}

/* ---------------- Post Ingredient ---------------- */
createIngredient(Map<String, dynamic> ingredients) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(ingredients);
  var url = Uri.http('10.0.2.2:8990', 'ingredients');
  http.Response response =
      await http.post(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

postIngredientToJson(String name, String url, double price) {
  // Map Key/Value für Users
  Map<String, dynamic> json = Map<String, dynamic>();
  json['name'] = name;
  json['url'] = url;
  json['price'] = price;

  // erstellen des Users
  createIngredient(json);
}

/* ---------------- Delete Ingredient ---------------- */
deleteIngredients(Map<String, dynamic> ingredients, String id) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(ingredients);
  var url = Uri.http('10.0.2.2:8990', 'ingredients/$id');
  http.Response response =
      await http.delete(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

deleteIngredientsFromJson(String id) {
  Map<String, dynamic> json = Map<String, dynamic>();
  json['name'] = '';
  json['url'] = '';
  json['price'] = '';
  // löschen des Users
  deleteIngredients(json, id);
}

/* ---------------- Put Ingredient ---------------- */
updateIngredients(Map<String, dynamic> ingredients, String id) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(ingredients);
  var url = Uri.http('10.0.2.2:8990', 'ingredients/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

updateIngredientsToJson(String id, String name, String url, double price) {
  Map<String, dynamic> updateMap = Map<String, dynamic>();

  updateMap['id'] = id;
  updateMap['name'] = name;
  updateMap['url'] = url;
  updateMap['price'] = price;

  // löschen des Users
  updateIngredients(updateMap, id);
}
