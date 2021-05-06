import 'package:flutter/material.dart';

class RegistryPage extends StatelessWidget {
  RegistryPage({Key key, this.title, this.registry}) : super(key: key);

  final String title;
  final String registry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Registrierung"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250.0,
                height: 40.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Vorname:",
                    icon: Icon(
                      Icons.person,
                    ),
                    hintStyle: TextStyle(
                      backgroundColor: Colors.blue[900],
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250.0,
                height: 40.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nachname:",
                    icon: Icon(
                      Icons.person,
                    ),
                    hintStyle: TextStyle(
                      backgroundColor: Colors.blue[900],
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
