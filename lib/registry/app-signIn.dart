import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app-signUp.dart';
import 'registry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tipple_app/front-end/menu-Items.dart';

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

                  //Intro Text
                  RichText(
                    text: TextSpan(
                      text: 'Moin!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Einloggen und schon kann es losgehen',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),

                  //Enter Mail
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0x80000000),
                    ),
                    textAlign: TextAlign.center,
                    controller: emailController,
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
                      hintText: "E-Mail",
                    ),
                  ),

                  //Enter PW
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0x80000000),
                    ),
                    textAlign: TextAlign.center,
                    controller: passwordController,
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
                      hintText: "Passwort",
                    ),
                  ),

                  //Login Btn
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 190.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      // padding: EdgeInsets.all(17.0),
                      onPressed: () {
                        print(userId);
                        login(emailController.text);
                        if (loggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
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
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Du hast noch keinen Account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppSignUp()),
                        )
                      },
                      child: Container(
                        child: Text(
                          "Registrieren",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F6C9C),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Get user by email - controllerEmail = email
  //A
  Future<Registry> getUserByEmail(String email) async {
    var url = Uri.http('10.0.2.2:8990', 'users/email/$email');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return Registry.fromJson(json.decode(response.body));
    } else {
      throw Exception(msgEmailIncorrect);
    }
  }
  // E

  login(String emailControl) async {
    Registry registry = await getUserByEmail(emailControl);
    userId = registry.id;
    userFirstName = registry.firstName;
    userLastName = registry.lastName;

    if (registry == null) {
      print(msgEmailIncorrect);
    }

    bool checkEmail = emailControl == registry.email;
    bool checkPassword = passwordController.text == registry.password;
    if (checkEmail && checkPassword) {
      loggedIn = true;
      print('Du hast dich erfolgreich eingeloggt.');
    } else {
      print(msgPasswordIncorrect);
    }
  }
}
