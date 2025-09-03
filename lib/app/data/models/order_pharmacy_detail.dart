import 'package:pharmix/app/data/models/order_detail.dart';

class OrderPharmacyDetail {
  final int id;
  final int orderDetailId;
  final bool available;
  final OrderDetail? orderDetails;
  final int quantity;
  final double price;
  final double total;

  OrderPharmacyDetail({
    required this.id,
    required this.orderDetailId,
    required this.available,
    required this.quantity,
    required this.price,
    this.orderDetails,
    required this.total,
  });

  factory OrderPharmacyDetail.fromJson(Map<String, dynamic> json) {
    return OrderPharmacyDetail(
      id: int.parse(json['id'].toString()),
      orderDetailId: int.parse(json['order_detail_id'].toString()),
      available: json['available'],
      quantity: int.parse(json['quantity'].toString()),
      price: (json['price'] as num).toDouble(),
      orderDetails: OrderDetail.fromJson(json['details']),
      total: (json['total'] as num).toDouble(),
    );
  }
}
