import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/registry/app-signUp.dart';
import 'Configurator/cart.dart';


void main() {
  runApp(Phoenix(child: ChangeNotifierProvider(
      create: (context) => Cart(), child: TippleApp())));
}

class TippleApp extends StatefulWidget {
  TippleApp({Key key}) : super(key: key);

  @override
  _TippleAppState createState() => _TippleAppState();
}

class _TippleAppState extends State<TippleApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppSignUp(),
    );
  }
}
