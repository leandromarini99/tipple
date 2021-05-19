import 'package:flutter/material.dart';
import 'package:tipple_app/front-end/menu-Items-drawer.dart';
import 'package:tipple_app/registry/app-signUp.dart';
import 'package:tipple_app/front-end/configuration-list.dart';

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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Tipple",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
              fit: BoxFit.fill
              )
            ),
            child: Center()),
      ),
    );
  }
}
