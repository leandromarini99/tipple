import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/registry/address-page.dart';
import 'package:tipple_app/registry/app-signIn.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'package:tipple_app/registry/registry-utility.dart';
import 'package:tipple_app/updateProfile/updateUserEmail-page.dart';
import 'package:tipple_app/updateProfile/updateUserPassword-page.dart';


class UpdateUserSettingsMenu extends StatelessWidget {
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
        child: ListView(
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                // build(context)
                "assets/logo.png",
                width: 200,
                height: 200,
                // fit: BoxFit.fill,
              ),

              //Greeting Text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Mein Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 40.0, bottom: 15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddressPage(registry: fetchUserById(userId),)),
                    );
                  },
                  child: Text(
                    "Adresse ergänzen",
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

              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserSettingsEmail(),),
                    );
                  },
                  child: Text(
                    "E-Mail anpassen",
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

              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserSettings()),
                    );
                  },
                  child: Text(
                    "Passwort anpassen",
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
          )],
        ),
      ),
    );
  }
}
