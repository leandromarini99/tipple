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
    return (responseJson as List)
        .map((config) => Configuration.fromJson(config))
        .toList();
  } else {
    throw Exception('Failed to laod configurations');
  }
}