import 'package:pharmix/app/data/models/order_pharmacy_detail.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';

class OrderPharmacy {
  final int id;
  final int orderId;
  final int treated_count;
  final String status;
  final Pharmacy? pharmacy;
  final List<OrderPharmacyDetail>? details;

  OrderPharmacy({
    required this.id,
    required this.orderId,
    required this.status,
    this.pharmacy,
    this.details,
    required this.treated_count,
  });

  factory OrderPharmacy.fromJson(Map<String, dynamic> json) {
    return OrderPharmacy(
        id: int.parse(json['id'].toString()),
        orderId: int.parse(json['order_id'].toString()),
        status: json['status'],
        pharmacy: json['pharmacy'] != null
            ? Pharmacy.fromJson(json['pharmacy'])
            : null,
        details: json['details'] != null
            ? (json['details'] as List)
                .map((item) => OrderPharmacyDetail.fromJson(item))
                .toList()
            : null,
        treated_count: int.parse(json['treated_count'].toString()));
  }
}
