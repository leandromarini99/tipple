import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/configuration/configuration.dart';
import 'package:tipple_app/configuration/configurator-service.dart';

import '../configuration/configuration-page.dart';
import 'package:flutter/material.dart';
import 'package:tipple_app/registry/app-signIn.dart' as signIn;

import 'cart.dart';
import '../menu-Items.dart';

class CartControls extends StatelessWidget {
  final String title;
  final Object config;
  final double totalPrice;
  const CartControls({Key key,  this.title, this.config, this.totalPrice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var page = title == 'cart';
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          children:[
            SizedBox(height: 24),
            Center(child: Text('\€$totalPrice',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
            ),),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    child: Text(
                      'Bestellen',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                          top: 17.0, bottom: 17.0, left: 30.0, right: 30.0),
                      primary: Color(0xFFFCC919),
                    ),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('Bestellung erfolgreich!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async  {
                                    if(page) {
                                      Cart cart = config;
                                      _create(context, false, cart);
                                    }else {
                                      _update(context, page);
                                    }
                                  },
                                  child: const Text('Alles klar'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 24),
                Container(
                  child: ElevatedButton(
                      child: Text(
                        (page)?'Speichern':'Entfernen',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 17.0, bottom: 17.0, left: 30.0, right: 30.0),
                        primary: Color((page) ? 0xA9A9A9A9: 0xF8FC2819),
                      ),
                      onPressed: () async {
                        if(page) {
                          Cart cart = config;
                          _create(context, page, cart);
                          cart.clearItems();
                        }else {
                          _delete(context);
                        }
                      }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    Configuration con = config;
    deleteConfiguration((con.id));
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        ConfigurationPage(title: 'Warenkorb')));
  }

  void _update(BuildContext context, bool cart) {
    Configuration con = config as Configuration;
    con.date = DateTime.now().toIso8601String();
    updateConfigurationToJson(con, false, cart );
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  void _create(BuildContext context, bool inCart, Cart cart) {
    createConfiguration(
        signIn.userId, inCart, cart.items);
    cart.clearItems();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MainPage()));
  }
}