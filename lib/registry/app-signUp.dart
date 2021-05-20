import 'package:flutter/material.dart';
import 'app-signIn.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSignUp extends StatelessWidget {
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController repeatPassworController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          )
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 16),
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
                    height: 10,
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
                      text: 'Registrieren und schon kann es losgehen',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),


                  //Enter FirstName
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextField(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0x80000000),
                          ),
                          textAlign: TextAlign.center,
                          controller: firstNameController,
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
                            hintStyle: TextStyle(
                              color: Color(0x80000000),
                            ),
                            hintText: "Vorname",
                          ),
                        ),
                      ),


                      //Enter lastName
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0x80000000),
                          ),
                          textAlign: TextAlign.center,
                          controller: lastNameController,
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
                            hintStyle: TextStyle(
                              color: Color(0x80000000),
                            ),
                            hintText: "Nachname",
                          ),
                        ),
                      ),
                    ],
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


                  //Repeat PW
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0x80000000),
                    ),
                    textAlign: TextAlign.center,
                    controller: repeatPassworController,
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
                      hintText: "Passwort wiederholen",
                    ),
                  ),


                  //Register Btn
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      child: Text(
                        "Registrieren",
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
                        "Du hast schon einen Account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppSignIn()),
                        );
                      },
                      child: Container(
                        child: Text(
                          "Login",
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

  void signUp() {
    postUserToJson(firstNameController.text, lastNameController.text, '',
        emailController.text, passwordController.text, '', 0, '', '');
    _clearFieldsAfterPost();
  }

  _clearFieldsAfterPost() {
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    repeatPassworController.text = '';
  }
}
