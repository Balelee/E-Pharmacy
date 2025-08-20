class Product {
  final int? id;
  final String name;
  final String? description;
  final double price;
  final String? category;
  final String? imageUrl;

  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.category,
    this.imageUrl,
  });

  // Méthode pour convertir un JSON en objet Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['type'],
      imageUrl: json['image'],
    );
  }

  // Méthode pour convertir un objet Product en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
