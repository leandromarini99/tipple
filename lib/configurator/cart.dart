
import 'package:flutter/cupertino.dart';
import 'package:tipple_app/ingredient/ingredient.dart';


class Cart extends ChangeNotifier {
  List<Ingredient> items = [];

  int get count => items.length;

  double get totalPrice => items.fold(0, (sum, item) => sum + 1.5);

  addToCart(Ingredient ingredient) {
    items.add(ingredient);
    notifyListeners();
  }

  remove(Ingredient ingredient) {
    items.remove(ingredient);
    notifyListeners();
  }

  clearItems() {
    items.clear();
    notifyListeners();
  }

  isNotEmpty() {
    items.isNotEmpty;
    notifyListeners();
  }
  bool equals(Cart cart) {
    bool find = false;
    return this.items.contains(cart);
  }


}