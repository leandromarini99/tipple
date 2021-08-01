import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/configuration/configurator-service.dart';
import 'package:tipple_app/configuration/configuration.dart';
import 'package:tipple_app/ingredient/ingredient.dart';
import 'package:tipple_app/registry/app-signIn.dart';
import 'package:tipple_app/service/future_extract_service.dart';

import 'edit-configuration-page.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    Future<List<Configuration>> futureList =(title.contains('Warenkorb')) ?
    fetchConfigurationsInCartByUserId(userId)
        : fetchConfigurationsByUserId(userId);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backwardsCompatibility: false,
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
        body: FutureExtract<Configuration>(futureList)
            .extractList(
          (data) => (data == null)
              ? new Text(
                  'Du hast leider noch keine Konfiguration erstellt.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover,
                  )),
                  padding: const EdgeInsets.all(24.0),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ConfigurationViewer(
                      title: title,
                      configs: data,
                    )
                  ])),
        ));
  }
}

class ConfigurationViewer extends StatelessWidget {
  final String title;
  final List<Configuration> configs;

  const ConfigurationViewer({Key key, this.title, this.configs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isInCart = title == 'Warenkorb';
    if(!isInCart) {
      configs.sort((c1, c2)=> c2.date.compareTo(c1.date));
    }
    return Expanded(
      child: ListView.builder(
          itemCount: configs.length,
          itemBuilder: (context, index) => LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: Column(children: [
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Datum : ' + configs[index].date.substring(0, 10),
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
                        'Getränkzutaten :',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                  Column(children: [
                    _createIngredientList(configs[index].ingredient, isInCart),
                    // SizedBox(height: 8),
                  ]),
                  Container(
                    // alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1,),
                      // child: CheckboxWidget(),
                      child: (!isInCart)
                          ? ConfigShareWidget(config: configs[index],)
                          : _OrderButton(config: configs[index],),
                    ),
                  )
                ]),
              )),
    );
  }

  Widget _createIngredientList(List<Ingredient> ingredients, bool isInCart) {
    return Column(children: [
      for (Ingredient ingredient in ingredients)
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFFFFFFF),
              ),
              borderRadius: BorderRadius.all(Radius.lerp(Radius.circular(30),
                  Radius.elliptical(30, 30), 1.0)),
              color: Color((isInCart) ? 0x80000000 : 0xFFFCC919)),
          padding: EdgeInsets.all(8),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 1, top: 2),
              child: Image.asset(
               ingredient.image,
                width: 50,
                height: 50,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 20, top: 9),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ingredient.name,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color((isInCart) ? 0xFFFFFFFF : 0xBF000000),
                  ),
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.only( top: 9),
              child: Text(
                calculateMix(ingredients.length),
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color((isInCart) ? 0xFFFFFFFF : 0xBF000000),
                ),
              ),
            ),
          ]),
        ),
    ]);
  }

  String calculateMix(int ingredientCount) {
    int ml = 1000 ~/ ingredientCount;
    return ml.toString() + ' ml';
  }
}

class ConfigShareWidget extends StatefulWidget {
  ConfigShareWidget({Key key, this.config}) : super(key: key);

  final Configuration config;

  @override
  State<ConfigShareWidget> createState() =>
      _ConfigShareWidgetState( isShared: config.share, config: config);
}

class _ConfigShareWidgetState extends State<ConfigShareWidget> {
  _ConfigShareWidgetState({this.isShared, this.config});

  Configuration config;
  bool isShared;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8, ),
          child: Text((!isShared)
          ? 'Möchtest du diese Konfiguration teilen?'
          : 'Diese Konfiguration ist geteilt!',
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF000000))
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Switch(
            activeColor: Colors.green[600],
            inactiveThumbColor: Color(0xFFFCC919),
            value: isShared,
            onChanged: (newValue) {
              updateConfigurationToJson(config, newValue, config.cart);
              setState(() {
                isShared = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}

class _OrderButton extends StatelessWidget {
  final Configuration config;

  const _OrderButton({this.config, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8, right: 6),
        child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        EditConfigPage(config: config,)));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFFCC919)),
              ),
              child: Text(
                'Bearbeiten',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  // color: Color(0xFFFCC919),
                  color: Colors.white,
                ),
              ),
            )));
  }
}
