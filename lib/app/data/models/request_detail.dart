import 'package:flutter/material.dart';

class RequestDetail {
  final int? id;
  final int? requestId;
  final int? productId;
  final String? productName;
  final String? quantity;
  final String? priceUnitaire;
  final String? status;
  final String? statusLabel;
  final Color? statusColor;
  final String? imageUrl;

  RequestDetail({
    this.id,
    this.requestId,
    this.productId,
    this.productName,
    this.quantity,
    this.priceUnitaire,
    this.status,
    this.statusLabel,
    this.statusColor,
    this.imageUrl,
  });

  factory RequestDetail.fromJson(Map<String, dynamic> json) {
    return RequestDetail(
      id: json['id'],
      requestId: json['request_id'],
      productId: json['product_id'],
      productName: json['productName'],
      quantity: json['quantity'].toString(),
      imageUrl: json['productImage'],
      priceUnitaire: (json['priceUnitaire'] as num).toString(),
      statusLabel: json['statusLabel'],
      status: json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'product_id': productId,
      'productName': productName,
      'quantity': quantity,
      'priceUnitaire': priceUnitaire,
      'imageUrl': imageUrl,
    };
  }
}
