class Drink {
  String id;
  String name;
  String category;
  double price;
  String imageUrl;
  List<String> ingredients;
  int quantity;

  Drink({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.ingredients,
    this.quantity = 0,
  });

  factory Drink.fromFirestore(Map<String, dynamic> data) {
    return Drink(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'quantity': quantity,
    };
  }
}
