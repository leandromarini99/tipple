class Ingredient {
  const Ingredient({this.id, this.name, this.url, this.price});

  final String id;
  final String name;
  final String url;
  final double price;

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        price: json['price']);
  }
}
