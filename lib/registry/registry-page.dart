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
              _buildTextbox("Vorname", Icons.arrow_back_outlined),
              _buildTextbox("Nachname", Icons.person),
              _buildTextbox("Email", Icons.person),
              _buildTextbox("Passwort", Icons.person),
              _buildTextbox("Passwort wiederholen", Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextbox(String nameValue, IconData iconNameValue) {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(
          labelText: nameValue,
          icon: Icon(iconNameValue),
          hintStyle: TextStyle(
            backgroundColor: Colors.blue[900],
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
