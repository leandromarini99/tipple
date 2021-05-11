import 'ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Ingredient>> fetchIngredients() async {
  var url = Uri.http('10.0.2.2:8990', 'ingredients');

  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    updateIngredientsToJson('42924f77-b70d-4e4f-a360-4eb20e014739');
    return (responseJson as List)
        .map((ingre) => Ingredient.fromJson(ingre))
        .toList();
  } else {
    throw Exception('Failed to laod ingredients');
  }
}

updateIngredients(Map<String, dynamic> ingredients, String id) async {
  const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var encodedBody = json.encode(ingredients);
  print(encodedBody);
  var url = Uri.http('10.0.2.2:8990', 'ingredients/$id');
  http.Response response =
      await http.put(url, body: encodedBody, headers: header);
  print(response.statusCode);
}

updateIngredientsToJson(String id) {
  Map<String, dynamic> updateMap = Map<String, dynamic>();

  updateMap['id'] = id;
  updateMap['name'] = 'Melon';
  updateMap['url'] = 'www.melon.de';
  updateMap['price'] = '3.50';

  // löschen des Users
  updateIngredients(updateMap, id);
}
