import 'package:flutter/material.dart';
import 'app-signIn.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registry-utility.dart';

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
        )),
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
                 greet(),
                 displayMsg('Registrieren und schon kann es losgehen'),
                  //Enter FirstName
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                     createFlexible(firstNameController, "Nachname"),
                      SizedBox(
                        width: 10,
                      ),
                      createFlexible(lastNameController, "Vorname"),
                    ],
                  ),

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
                  //Repeat PW
                  SizedBox(
                    height: 15,
                  ),
                   createTextField(repeatPassworController,true, "Passwort wiederholen"),
                  //Register Btn
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool istErfolg = await signUp();
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                                (istErfolg) ?'Erfolgreich registriert'
                                :'Leider ist die Registrierung schiefgegangen!'
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => (istErfolg)?Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppSignIn()),
                                ):Navigator.of(context).pop(),
                                child: const Text('Alles klar'),
                              ),
                            ],
                          ),
                        );
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
            createRowWithNavigator('Du hast schon einen Account?',
                context,
                MaterialPageRoute(builder: (context) => AppSignIn()),
              'Login')
            
          ],
        ),
      ),
    );
  }


  Future<bool> signUp() async{
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var status = await checkEmailAvailability(emailController.text);
      if(status != 200)
        return false; // email ist schon vergaben.

      postUserToJson(firstNameController.text, lastNameController.text, '',
          emailController.text, passwordController.text, '', 0, '', '');
      _clearFieldsAfterPost();
      return true;
    }
    return false;
  }

  _clearFieldsAfterPost() {
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    repeatPassworController.text = '';
  }
}
