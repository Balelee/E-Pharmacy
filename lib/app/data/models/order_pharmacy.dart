import 'package:pharmix/app/data/models/order_pharmacy_detail.dart';

class OrderPharmacy {
  final int id;
  final int orderId;
  final int pharmacyId;
  final String status;
  final List<OrderPharmacyDetail> details;

  OrderPharmacy({
    required this.id,
    required this.orderId,
    required this.pharmacyId,
    required this.status,
    required this.details,
  });

  factory OrderPharmacy.fromJson(Map<String, dynamic> json) {
    return OrderPharmacy(
      id: int.parse(json['id'].toString()),
      orderId: int.parse(json['order_id'].toString()),
      pharmacyId: int.parse(json['pharmacy_id'].toString()),
      status: json['status'],
      details: (json['details'] as List)
          .map((item) => OrderPharmacyDetail.fromJson(item))
          .toList(),
    );
  }
}
