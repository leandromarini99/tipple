import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/configuration/configuration-page.dart';
import 'package:tipple_app/registry/app-signIn.dart';
import 'package:tipple_app/updateProfile/updateUserSetting-menu.dart';

import 'Configurator/configurator-page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //Home screen
        appBar: AppBar(
          backgroundColor: Color(0xFFFCC919),
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
          title: Text(
            "TIPPLE",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFFFFFF),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () =>
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  AppSignIn()),),
              child: Icon(
                Icons.logout,
                color: Color(0xFFFFFFFF),
              ),
              style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color(0xFFFCC919)
                  )),
            ),
          ],
        ),
        // Menu
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFFFCC919),
          ),
          child: Drawer(
            child: ListView(
              children: <Widget>[
                //Header
                Container(
                  padding: EdgeInsets.only(right: 130),
                  child: Image.asset(
                    "assets/header.png",
                    height: 175,
                  ),
                ),

                //Username
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: userFirstName + ' ' + userLastName,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //Konto Btn
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateUserSettingsMenu()),
                      );
                    },
                    child: Text(
                      "Mein Konto",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(17.0),
                      primary: Color(0xFFFFFFFF),
                    ),
                  ),
                ),

                //Bestellungen Btn
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ConfigurationPage(title: 'Meine Bestellungen')));
                    },
                    child: Text(
                      "Meine Bestellungen",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(17.0),
                      primary: Color(0xFFFFFFFF),
                    ),
                  ),
                ),

                //Warenkorb Btn
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfigurationPage(title: 'Warenkorb')));
                    },
                    child: Text(
                      "Warenkorb",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(17.0),
                      primary: Color(0xFFFFFFFF),
                    ),
                  ),
                ),

                //Einstellungen Btn
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Einstellungen",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(17.0),
                      primary: Color(0xFFFFFFFF),
                    ),
                  ),
                ),

                //FAQ Btn
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO
                      Navigator.pop(context);
                    },
                    child: Text(
                      "FAQ",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(17.0),
                      primary: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 16),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[
                //Logo
                Image.asset(
                  // build(context)
                  "assets/logo.png",
                  width: 200,
                  height: 200,
                ),

                //Greeting Text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Moin ' + userFirstName + '!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //Additional Text
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Herzlich Willkommen bei Tipple. Mit dieser App kannst du eigene Säfte zusammenstellen.'
                          ' Dafür stehen dir diverse natürliche Zutaten zur Auswahl,'
                          ' welche beliebig miteinander kombiniert werden können. Du '
                          'kannst das Getränk also ganz nach deinem eigenen Geschmack gestalten '
                          'oder einfach experimentieren. Viel Spaß!',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),

                //Configurator Btn
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfiguratorPage()),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ChangeNotifierProvider(
                      //           create: (context) => ConfiguratorPage(),  child: ConfiguratorPage()),
                      // );

                      // context.select<Cart, void>(
                      //         (cart) => cart.items.clear());
                    },
                    child: Text(
                      "Zum Konfigurator",
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
            )),
      ),
    );
  }
}
