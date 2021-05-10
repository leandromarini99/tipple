import 'registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Registry>> fetchRegistry() async {
  var url = Uri.http('10.0.2.2:8990', 'users');

  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((user) => Registry.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to laod Users');
  }

}
