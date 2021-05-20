import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipple_app/ingredient/ingredient-service.dart';
import 'package:tipple_app/ingredient/ingredient.dart';

import 'cart.dart';
import 'catalog.dart';

// class ConfigRunner extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Using MultiProvider is convenient when providing multiple objects.
//     return MultiProvider(
//       providers: [
//         // In this sample app, CatalogModel never changes, so a simple Provider
//         // is sufficient.
//         Provider(create: (context) => MyCatalog(ingredients: fetchIngredients())),
//         // CartModel is implemented as a ChangeNotifier, which calls for the use
//         // of ChangeNotifierProvider. Moreover, CartModel depends
//         // on CatalogModel, so a ProxyProvider is needed.
//         ChangeNotifierProxyProvider<Ingredient, CartModel>(
//           create: (context) => CartModel(),
//           update: (context, catalog, cart) {
//             if (cart == null) throw ArgumentError.notNull('cart');
//             cart.catalog = catalog;
//             return cart;
//           },
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Provider Demo',
//         // theme: appTheme,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => MyCatalog(ingredients: fetchIngredients()),
//           '/cart': (context) => MyCart(),
//         },
//       ),
//     );
//   }
 
// }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tipple Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCatalog(ingredients: fetchIngredients(),),
    );
  }
}
void main() {
    runApp(MyApp());
  }
