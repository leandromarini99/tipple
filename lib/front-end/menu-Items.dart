import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/configuration/configurator-page.dart';
import 'package:tipple_app/front-end/menu-Items-drawer.dart';
import 'package:tipple_app/registry/app-signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ML Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          divisionColor: Colors.grey,
          header: Container(
            height: size.height * 0.25,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  // build(context)
                  "assets/user-profile.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Benutzer-Name")
              ],
            )),
          ),
          children: [
            MLMenuItem(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Mein Konto",
                ),
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_right),
                content: Text("Einstellungen"),
                onClick: () {}
            ),
            MLMenuItem(
              leading: Icon(Icons.add_shopping_cart),
              content: Text("Cart"),
              onClick: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                 (context) => AppSignUp()));
              },
            ),
            MLMenuItem(
                leading: Icon(Icons.archive),
                // leading: Icon(Icons.payment),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Meine Bestellungen",
                ),
                onClick: () {
                //    Navigator.of(context).push(MaterialPageRoute(builder:
                //  (context) => ConfiguratorInfo()));
                }),
            MLMenuItem(
                leading: Icon(Icons.question_answer),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "FAQ",
                ),
                onClick: () {}),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFFCC919),
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
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
              fit: BoxFit.cover
              )
            ),
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
                     text: 'Moin Username!',
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
                     text: 'Herzlich Willkommen bei Tipple. Mir dieser App kannst du eigene Säfte zusammenstellen.'
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
                     ConfiguratorPage(); //TODO
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
          )
        ),
      ),
    );
  }
}
