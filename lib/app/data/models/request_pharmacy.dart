import 'package:pharmix/app/data/models/request_pharmacy_detail.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';

class RequestPharmacy {
  final int id;
  final int requestId;
  final int treated_count;
  final String status;
  final Pharmacy? pharmacy;
  final List<RequestPharmacyDetail>? details;

  RequestPharmacy({
    required this.id,
    required this.requestId,
    required this.status,
    this.pharmacy,
    this.details,
    required this.treated_count,
  });

  factory RequestPharmacy.fromJson(Map<String, dynamic> json) {
    return RequestPharmacy(
        id: int.parse(json['id'].toString()),
        requestId: int.parse(json['request_id'].toString()),
        status: json['status'],
        pharmacy: json['pharmacy'] != null
            ? Pharmacy.fromJson(json['pharmacy'])
            : null,
        details: json['details'] != null
            ? (json['details'] as List)
                .map((item) => RequestPharmacyDetail.fromJson(item))
                .toList()
            : null,
        treated_count: int.parse(json['treated_count'].toString()));
  }
}
