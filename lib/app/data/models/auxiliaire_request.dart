import 'package:flutter/material.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/data/models/request_detail.dart';

class AuxiliaireRequest extends Request {
  final String? clientPhone;
  final String? date;

  AuxiliaireRequest({
    required super.id,
    required super.number,
    required super.amount,
    required super.status,
    required super.statusLabel,
    required super.statusColor,
    required super.requestDetails,
    this.clientPhone,
    this.date,
  });

  factory AuxiliaireRequest.fromJson(Map<String, dynamic> json) {
    return AuxiliaireRequest(
      id: json['id'],
      number: json['request_number'].toString(),
      amount: json['priceTotal'].toString(),
      statusLabel: json['statusLabel'],
      status: json['status'],
      statusColor: Color(int.parse(json['statusColor'] ?? '0xFFF44336')),
      requestDetails: (json['details'] as List)
          .map((item) => RequestDetail.fromJson(item))
          .toList(),
      clientPhone: json['client_phone'],
      date: json['date'],
    );
  }
}
