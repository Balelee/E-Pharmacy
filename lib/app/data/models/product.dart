class Product {
  final int id;
  final String name;
  final String description;
  final int stock;
  final double price;
  final String category;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  // Méthode pour convertir un JSON en objet Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }

  // Méthode pour convertir un objet Product en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock': stock,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
