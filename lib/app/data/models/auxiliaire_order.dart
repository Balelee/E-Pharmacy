import 'package:flutter/material.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/models/order_detail.dart';

class AuxiliaireOrder extends Order {
  final String? clientPhone;

  AuxiliaireOrder({
    required super.id,
    required super.amount,
    required super.status,
    required super.statusLabel,
    required super.statusColor,
    required super.orderDetails,
    this.clientPhone,
  });

  factory AuxiliaireOrder.fromJson(Map<String, dynamic> json) {
    return AuxiliaireOrder(
      id: json['id'],
      amount: json['priceTotal'].toString(),
      statusLabel: json['statusLabel'],
      status: json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
      orderDetails: (json['details'] as List)
          .map((item) => OrderDetail.fromJson(item))
          .toList(),
      clientPhone: json['client_phone'],
    );
  }
}
