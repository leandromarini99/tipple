
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/ingredient/ingredient-service.dart';
import 'package:tipple_app/ingredient/ingredient.dart';
import 'package:tipple_app/service/future_extract_service.dart';

import 'cart-page.dart';
import 'cart.dart';
class ConfiguratorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return FutureExtract<Ingredient>(fetchIngredients())
        .extractList((data) => Consumer<Cart>(builder: (context, cart, child) {
              return Scaffold(
                appBar: _buildAppBar(context, cart),
                body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    )),
                    padding: EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        _IngredientViewer(
                          data: data,
                          cart: cart,
                        ),
                      ],
                    )),
              );
            }));
  }

  Widget _buildAppBar(BuildContext context, Cart cart) {
    return AppBar(
      // automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFFCC919),
      title: Text('Konfigurator',  style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFFFFFF),),),
      actions: [
        FloatingActionButton.extended(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () =>
          (cart.items.isNotEmpty) ?
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  CartPage()),)
              : null,
          backgroundColor: Color(0xFFFCC919),
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          label: Text(
            cart.count.toString(),
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ],
    );
  }


}

class _IngredientViewer extends StatelessWidget {
  final List<Ingredient> data;
  final Cart cart;
  const _IngredientViewer({Key key, this.data, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.sort((i1, i2) => i1.name.compareTo(i2.name));
    return Expanded(
        child: ListView.builder(
          addAutomaticKeepAlives: false,
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: LimitedBox(
                  maxHeight: 48,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1, top: 0),
                      // padding: EdgeInsets.all(8),
                      child: Image.asset( data[index].image,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 9),
                      child: Text(
                        data[index].name,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xBF000000),
                        ),
                      ),
                    )),
                    SizedBox(width: 24),
                    _AddButton(ingredient: data[index],),
                  ]),
                ))));
  }

}

class _AddButton extends StatelessWidget {
  final Ingredient ingredient;

  const _AddButton({Key key, this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<Cart, bool>(
          (cart) => cart.items.contains(ingredient),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
        var cart = context.read<Cart>();
        cart.addToCart(ingredient);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED')
          :  Icon(Icons.add_circle_outline, color:  Color(0xFFA5A3A3),semanticLabel: 'ADD')
      // Text(
      //   'ADD',
      //   style: GoogleFonts.poppins(
      //     fontSize: 16,
      //     fontWeight: FontWeight.w500,
      //     color: Color(0xFFFCC919),
      //   ),
      // ),
    );
  }
}