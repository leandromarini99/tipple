import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/configuration/configurator-service.dart';
import 'package:tipple_app/configuration/ingredient-configurator.dart';
import 'package:tipple_app/ingredient/ingredient.dart';
import 'package:tipple_app/registry/app-signIn.dart';

class ConfigApp extends StatelessWidget {
  const ConfigApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(

        //  Header
        appBar: AppBar(
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: Color(0xFFFCC919),
        ),


        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            )
          ),
          padding: const EdgeInsets.all(24.0),
          width: double.infinity,
          height: double.infinity,

          child: SingleChildScrollView(
            child: ConfigStatelessWidget(title: title,
              futureList: fetchConfigurationsByUserId(
                  userId) // userId
            ),
          ),
        ),
      ),
    );
  }
}

class ConfigStatelessWidget extends StatelessWidget {
  const ConfigStatelessWidget({this.title,this.futureList, Key key}) : super(key: key);
  final Future<List<Configuration>> futureList;
  final String title;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Configuration>>(
        future: this.futureList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return Column(children: _createColumn(context, snapshot.data));
          }
        });
  }

  List<Column> _createColumn(
      BuildContext context, List<Configuration> configs) {
    List<Column> columns = [];
    bool isInCart = title=='Warenkorb';
    for (Configuration config in configs) {
      columns.add(
        Column(children: [
          SizedBox(
            height: 16,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Datum : ' + config.date.substring(0, 10),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                'Getränk :',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0x80000000),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color(0xFFFFFFFF)
              ),
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Table(children: _createIngredientRows(config.ingredient))
              ])),
            Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 1, bottom: 2),
              // child: CheckboxWidget(),
              child: (!isInCart)? Row(
                children: <Widget>[
                  CheckboxWidget(share: config.share),
                  Expanded(child: Text('Do you want to share it?')),
                ],
              ):Text(''),
            ),
          )
        ]),
      );
    }
    return columns;
  }

  List<TableRow> _createIngredientRows(List<Ingredient> ingredients) {
    List<TableRow> rows = [];
    // prepare header

    // prepare data
    for (Ingredient ingredient in ingredients) {
      rows.add(TableRow(children: [

        TableCell(
            child: Padding(
                padding: EdgeInsets.only(left: 40, top: 2),
                child: Text(
                    'Zutat:',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xBF000000),
                    ),
                )
            )
        ),

        TableCell(
            child: Padding(
                padding: EdgeInsets.only(left: 60, top: 2),
                child: Text(
                    ingredient.name,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xBF000000),
                    ),
                )
            )
        ),
      ]));
    }
    return rows;
  }
}

class CheckboxWidget extends StatefulWidget {
  CheckboxWidget({Key key, this.share}) : super(key: key);
  final bool share;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState(isChecked: share);
}

/// This is the private State class that goes with MyStatefulWidget.
class _CheckboxWidgetState extends State<CheckboxWidget> {
  _CheckboxWidgetState({this.isChecked});
  bool isChecked;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (isChecked) {
        return Colors.green[600];
      }
      return Colors.yellow[600];
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
