import 'package:tipple_app/ingredient/ingredient.dart';

class Configuration {
  final String id;
  final String userId;
  final String date;
  final bool share;
  final bool cart;
  final List<Ingredient> ingredient;
 const Configuration({
      this.id,
      this.userId,
      this.date,
      this.share,
      this.cart,
      this.ingredient});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
        id: json['id'],
        userId: json['userId'],
        date: json['date'],
        share: json['share'],
        cart: json['cart'],
        ingredient: (json['ingredients'] as List)
            .map((p) => Ingredient.fromJson(p))
            .toList());
  }
}
