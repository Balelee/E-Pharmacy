import 'package:e_pharma/app/data/models/product.dart';

class Searchproduct {
  final int? id;
  final String productName;
  final double price;

  Searchproduct({
    this.id,
    required this.productName,
    required this.price,
  });

  factory Searchproduct.fromJson(Map<String, dynamic> json) {
    return Searchproduct(
      id: json['id'],
      productName: json['productName'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }

  Product toProduct() {
    return Product(
      id: id,
      name: productName,
      price: price,

      // etc.
    );
  }
}
