import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/menu-Items.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'app-signUp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registry-utility.dart';

String userId;
String userFirstName;
String userLastName;

class AppSignIn extends StatefulWidget {
  @override
  _AppSignInState createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool loggedIn = false;
  String msgEmailIncorrect = 'Email nicht vorhanden';
  String msgPasswordIncorrect = 'Dein angegebenes Passwort ist falsch';

  @override
  Widget build(BuildContext context) {
    emailController.text = "toni@tipple.de";
    passwordController.text= "12345678";
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
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    alignment: Alignment.center,
                  ),

                  //Intro Text
                  greet(),
                  displayMsg('Einloggen und schon kann es losgehen'),
                  //Enter Mail
                  SizedBox(
                    height: 15,
                  ),
                  createTextField(emailController,false, "E_Mail"),
                  //Enter PW
                  SizedBox(
                    height: 15,
                  ),
                  createTextField(passwordController,true, "Password"),
                  //Login Btn
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 190.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      // padding: EdgeInsets.all(17.0),
                      onPressed: () async{
                        print(userId);
                        await login(emailController.text);
                        if (loggedIn) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()),
                          );
                        }
                      },
                      child: Text(
                        "Login",
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            createRowWithNavigator('Du hast noch keinen Account?',
                context,
                MaterialPageRoute(builder: (context) => AppSignUp()),
              'Registrieren')
          ],
        ),
      ),
    );
  }

  // Get user by email - controllerEmail = email
  //A
  Future<dynamic> postCredential(String email) async {
    var url = Uri.http('10.0.2.2:8990', 'users/login');
    Map<String, dynamic> loginMap = Map<String, dynamic>();
    loginMap["email"] = emailController.text;
    loginMap["password"] = passwordController.text;
    var encodedBody = json.encode(loginMap);
    http.Response response =
    await http.post(url, body: encodedBody, headers: HEADER);
    print(response.body);
    return json.decode(response.body);
  }
  // E

  login(String emailControl) async{
    Map<String, dynamic> json = await postCredential(emailControl);
    loggedIn = json["verified"];
    if(loggedIn) {
      userId = json["userId"];
      userFirstName = json["firstName"];
      userLastName = json["lastName"];
    }else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Passwort  oder E-Mail'),
          content: const Text('stimmen nicht überein'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Neuer Versuch'),
              child: const Text('Neuer Versuch'),
            ),
          ],
        ),
      );
    }

  }
}
