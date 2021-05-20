import 'package:flutter/material.dart';
import 'updateUserSettings-service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';

class UpdateUserSettings extends StatefulWidget {
  @override
  _UpdateUserSettings createState() => _UpdateUserSettings();
}

class _UpdateUserSettings extends State<UpdateUserSettings> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repeatPasswordController = new TextEditingController();
  String msgPasswordUpdated = 'Du hast dein Passwort erfolgreich geändert.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    alignment: Alignment.center,
                  ),
                  //Enter Mail
                  SizedBox(
                    height: 15,
                  ),
                  _textbox('Email', emailController),

                  //Enter PW
                  SizedBox(
                    height: 15,
                  ),
                  _textbox('Passwort', passwordController),

                  //repeat PW
                  SizedBox(
                    height: 15,
                  ),
                  _textbox('wiederhole Passwort', repeatPasswordController),

                  //Login Btn
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 190.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      // padding: EdgeInsets.all(17.0),
                      onPressed: () {},
                      child: Text(
                        "Passwort ändern",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(17.0),
                        primary: Color(0xFFFCC919),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget _textbox(String hintText, TextEditingController inputController) {
  return TextField(
    style: GoogleFonts.poppins(
      fontSize: 14,
      color: Color(0x80000000),
    ),
    textAlign: TextAlign.center,
    controller: inputController,
    showCursor: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.none,
        ),
      ),
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      hintStyle: TextStyle(color: Color(0x80000000)),
      hintText: hintText,
    ),
  );
}
