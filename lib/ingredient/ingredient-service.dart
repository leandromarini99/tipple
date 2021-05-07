
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
