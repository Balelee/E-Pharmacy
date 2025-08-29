import 'package:flutter/material.dart';
import 'package:pharmix/app/data/models/order_detail.dart';

class Order {
  final int id;
  final String amount;
  final String status;
  final String statusLabel;
  final Color statusColor;
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.amount,
    required this.status,
    required this.statusLabel,
    required this.statusColor,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      amount: json['priceTotal'].toString(),
      statusLabel: json['statusLabel'],
      status: json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
      orderDetails: (json['details'] as List)
          .map((item) => OrderDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'statusColor': statusColor.value,
      'orderDetails': orderDetails.map((item) => item.toJson()).toList(),
    };
  }
}
