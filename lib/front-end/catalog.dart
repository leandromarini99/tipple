// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/front-end/cart.dart';
import 'package:tipple_app/ingredient/ingredient.dart';

class MyCatalog extends StatelessWidget {
  final Future<List<Ingredient>> ingredients;
  const MyCatalog({this.ingredients, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       _MyAppBar(),
    //       SliverToBoxAdapter(child: SizedBox(height: 12)),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //             (context, index) => _MyListItem(index)),
    //       ),
    //     ],
    //   ),
    // );
    return FutureBuilder<List<Ingredient>>(
        future: this.ingredients,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                // return Scaffold(
                //   body: CustomScrollView(
                //     slivers: [
                //       _MyAppBar(),
                //       SliverToBoxAdapter(child: SizedBox(height: 12)),
                //       SliverList(
                //         delegate: SliverChildBuilderDelegate(
                //             (context, index) => _MyListItem(snapshot.data)),
                //       ),
                //     ],
                //   ),
                // );
                return _MyListItem(snapshot.data);
          }
        });
  }
}

class _AddButton extends StatelessWidget {
  final Ingredient ingredient;

  const _AddButton({this.ingredient, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.ingredients.contains(ingredient),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var cart = context.read<CartModel>();
              cart.add(ingredient);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
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
  // final int index;
  final List<Ingredient> ingredients;

  _MyListItem(this.ingredients, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: _createIngredientRows(context, ingredients),
        ),
      ),
    );
  }
}

List<Row> _createIngredientRows(
    BuildContext context, List<Ingredient> ingredients) {
  var textTheme = Theme.of(context).textTheme.headline6;
  List<Row> rows = [];
  // prepare header

  // prepare data
  for (Ingredient ingredient in ingredients) {
    rows.add(Row(children: [
      Image.network(
          'https://www.ndr.de/ratgeber/kochen/warenkunde/orangen156_v-contentxl.jpg'),
      SizedBox(width: 24),
      Expanded(
        child: Text(ingredient.name, style: textTheme),
      ),
      SizedBox(width: 24),
      _AddButton(ingredient: ingredient),
    ]));
  }
  return rows;
}
