import 'registry-page.dart';
import 'package:flutter/material.dart';
import 'registry-service.dart';
import 'registry.dart';

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
  Future<List<Registry>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchRegistry();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Serverstatus monitor",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegistryPage(title: "Registry Page", registry: futureData),
    );
  }
}
