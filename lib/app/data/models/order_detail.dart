class OrderDetail {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final String quantity;
  final String priceUnitaire;
  final String? imageUrl;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.priceUnitaire,
    required this.imageUrl,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['productName'],
      quantity: json['quantity'].toString(),
      imageUrl: json['productImage'],
      priceUnitaire: (json['priceUnitaire'] as num).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'productName': productName,
      'quantity': quantity,
      'priceUnitaire': priceUnitaire,
      'imageUrl': imageUrl,
    };
  }
}
