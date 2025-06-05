class Searchproduct {
  final String productName;
  final double price;

  Searchproduct({
    required this.productName,
    required this.price,
  });

  factory Searchproduct.fromJson(Map<String, dynamic> json) {
    return Searchproduct(
      productName: json['productName'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}

