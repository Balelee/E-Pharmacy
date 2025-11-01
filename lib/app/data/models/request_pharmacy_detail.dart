import 'package:pharmix/app/data/models/request_detail.dart';

class RequestPharmacyDetail {
  final int id;
  final bool available;
  final RequestDetail? requestDetail;
  final int quantity;
  final double price;
  final double total;

  RequestPharmacyDetail({
    required this.id,
    required this.available,
    required this.quantity,
    required this.price,
    this.requestDetail,
    required this.total,
  });

  factory RequestPharmacyDetail.fromJson(Map<String, dynamic> json) {
    return RequestPharmacyDetail(
      id: int.parse(json['id'].toString()),
      available: json['available'],
      quantity: int.parse(json['quantity'].toString()),
      price: (json['price'] as num).toDouble(),
      requestDetail: RequestDetail.fromJson(json['request_detail']),
      total: (json['total'] as num).toDouble(),
    );
  }
}
