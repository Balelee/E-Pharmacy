import 'package:flutter/material.dart';
import 'package:pharmix/app/data/models/request_detail.dart';

class Request {
  final int id;
  final String number;
  final String amount;
  final String status;
  final String statusLabel;
  final Color statusColor;
  final List<RequestDetail> requestDetails;

  Request({
    required this.id,
    required this.number,
    required this.amount,
    required this.status,
    required this.statusLabel,
    required this.statusColor,
    required this.requestDetails,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      number: json['request_number'].toString(),
      amount: json['priceTotal'].toString(),
      statusLabel: json['statusLabel'],
      status: json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
      requestDetails: (json['details'] as List)
          .map((item) => RequestDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'statusColor': statusColor.value,
      'requestDetails': requestDetails.map((item) => item.toJson()).toList(),
    };
  }
}
