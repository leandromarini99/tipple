
class Ingredient {

  const Ingredient({this.id, this.name, this.url, this.price});

  final String id;
  final String name;
  final String url;
  final double price;

  factory Ingredient.fromJson(Map<String, dynamic> json) {
   
    return  Ingredient(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "price": price
  };

  @override
  bool operator ==(Object other) {
    return  (other is Ingredient) && this.name == other.name;
  }

  @override
  int get hashCode => super.hashCode;

  String get image => url ==null
      ? 'assets/' + name.toLowerCase() +'.png'
      : url.replaceAll('www.tipple.de/', '') +'.png';

}
