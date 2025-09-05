import 'package:pharmix/app/data/models/order_detail.dart';

class OrderPharmacyDetail {
  final int id;
  final bool available;
  final OrderDetail? orderDetail;
  final int quantity;
  final double price;
  final double total;

  OrderPharmacyDetail({
    required this.id,
    required this.available,
    required this.quantity,
    required this.price,
    this.orderDetail,
    required this.total,
  });

  factory OrderPharmacyDetail.fromJson(Map<String, dynamic> json) {
    return OrderPharmacyDetail(
      id: int.parse(json['id'].toString()),
      available: json['available'],
      quantity: int.parse(json['quantity'].toString()),
      price: (json['price'] as num).toDouble(),
      orderDetail: OrderDetail.fromJson(json['order_detail']),
      total: (json['total'] as num).toDouble(),
    );
  }
}
