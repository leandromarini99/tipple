import 'package:tipple_app/configuration/configurator-service.dart';
import 'ingredient-configurator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tipple_app/configuration/configurator-page.dart';

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
  Future<List<Configuration>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchConfigurations();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Serverstatus monitor",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConfiguratorPage(
          title: "Configuration Page", configurations: futureData),
    );
  }
}
