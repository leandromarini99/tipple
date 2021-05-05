import 'ingredient.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'ingredient-service.dart';
import 'ingredient-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
   Future<List<Ingredient>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Serverstatus monitor",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IngredientPage(
          title: "Ingredient Page", ingredients: futureData),
    );
  }
}
