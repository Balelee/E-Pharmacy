import 'package:flutter/material.dart';

class OrderDetail {
  final int? id;
  final int? orderId;
  final int? productId;
  final String? productName;
  final String? quantity;
  final String? priceUnitaire;
  final String? status;
  final String? statusLabel;
  final Color? statusColor;
  final String? imageUrl;

  OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.quantity,
    this.priceUnitaire,
    this.status,
    this.statusLabel,
    this.statusColor,
    this.imageUrl,
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
      statusLabel:json['statusLabel'],
      status:json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
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
