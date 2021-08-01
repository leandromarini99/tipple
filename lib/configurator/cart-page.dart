import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/configuration/configurator-service.dart';
import 'package:tipple_app/menu-Items.dart';
import 'package:tipple_app/registry/app-signIn.dart' as signIn;

import 'cart.dart';
import 'common-buttons.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, cart, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFFCC919),
              backwardsCompatibility: false,
              title: Text(
                'Konfiguration',
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
                    fit: BoxFit.cover,
                  )),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: _CartList(cart: cart),
                    ),
                  ),
                  Divider(height: 4, color: Colors.black),
                  // _CartTotal(cart: cart,)
                  CartControls(
                    title: 'cart', config: cart, totalPrice: cart.items.length * 1.5,
                  )
                ],
              ),
            ),
          );
        });
  }
}



class _CartList extends StatelessWidget {
  final Cart cart;

  const _CartList({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) =>
          ListTile(
            // leading: Icon(Icons.done),
            leading: Image.asset('${cart.items[index].image}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                cart.remove(cart.items[index]);
                if(cart.items.isEmpty) {
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/');
                }
              },
            ),
            title: Text(
              cart.items[index].name,
              style: itemNameStyle,
            ),
          ),
    );
  }
}


class _CartTotal extends StatelessWidget {
  final Cart cart;

  const _CartTotal({Key key, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\€${cart.totalPrice}',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(width: 24),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Bestellung erfolgreich!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => {
                            createConfiguration(
                                signIn.userId, false, cart.items),
                            cart.clearItems(),
                            Navigator.of(context).pop(),
                            Navigator.of(context).pop(),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage())),
                          },
                          child: const Text('Alles klar'),
                        ),
                      ],
                    ),
                  );
                },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

