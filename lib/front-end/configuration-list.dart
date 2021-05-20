// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tipple_app/configuration/configurator-service.dart';
import 'package:tipple_app/configuration/ingredient-configurator.dart';
import 'package:tipple_app/ingredient/ingredient.dart';

class ConfigApp extends StatelessWidget {
  const ConfigApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ConfigStatelessWidget(title: title,
            futureList: fetchConfigurationsByUserId(
                '229304a5-bf3c-44f0-acac-cf2a97e75c79')),
      ),
      // TODO get userId from login Info 
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
    for (Configuration config in configs) {
      columns.add(
        Column(children: [
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 9, bottom: 4),
              child: Text('Config Id: ' + config.id,
                  style: CupertinoTheme.of(context).textTheme.textStyle),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 9, bottom: 4),
              child: Text(
                'Date: ' + config.date,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 9, bottom: 4),
              child: Text(
                'Ingredients',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.2),
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.yellow),
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Table(children: _createIngredientRows(config.ingredient))
              ])),
            Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 1, bottom: 2),
              // child: CheckboxWidget(),
              child: Row(
                children: <Widget>[
                  CheckboxWidget(share: config.share),
                  Expanded(child: Text('Do you want to share it?')),
                ],
              ),
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
                padding: EdgeInsets.only(left: 20),
                child: Text('Name:', textAlign: TextAlign.left))),
        TableCell(
            child: Center(
                child: Text(
          ingredient.name,
          textAlign: TextAlign.end,
        )))
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
