// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/front-end/cart.dart';
import 'package:tipple_app/front-end/theme.dart';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  static List<String> itemNames = [
    'ananas',
    'apfel',
    'avocado',
    'banane',
    'birne',
    'erdbeere',
    'karotte',
    'kiwi',
    'kokosnuss',
    'mango',
    'orange',
    'tomate',
    'wassermelone',
    'weintraube',
    'zitrone',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final double price = 1.50;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            )),
        child: CustomScrollView(
          slivers: [
            _MyAppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(index)),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({ this.item, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text(
          'ADD',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFCC919),
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFFFCC919),
      title: Text('Konfigurator', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            Image.asset(
              // build(context)
              "assets/" + item.name + ".png",
              width: 50,
              height: 50,
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(
                  item.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyAppCataltog());
}

class MyAppCataltog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/',
        routes: {
          
          '/': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
