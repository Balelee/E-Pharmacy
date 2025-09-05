import 'package:pharmix/app/data/models/order_pharmacy_detail.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';

class OrderPharmacy {
  final int id;
  final int orderId;
  final String status;
  final Pharmacy pharmacy;
  final List<OrderPharmacyDetail> details;

  OrderPharmacy({
    required this.id,
    required this.orderId,
    required this.status,
    required this.pharmacy,
    required this.details,
  });

  factory OrderPharmacy.fromJson(Map<String, dynamic> json) {
    return OrderPharmacy(
      id: int.parse(json['id'].toString()),
      orderId: int.parse(json['order_id'].toString()),
      status: json['status'],
      pharmacy: Pharmacy.fromJson(json['pharmacy']),
      details: (json['details'] as List)
          .map((item) => OrderPharmacyDetail.fromJson(item))
          .toList(),
    );
  }
}
