import 'package:flutter/material.dart';

class Tip {
  final String title;
  final String content;
  final String icon;

  Tip({
    required this.title,
    required this.content,
    required this.icon,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      title: json['title'],
      content: json['content'],
      icon: json['icon'],
    );
  }

  IconData get iconData {
    switch (icon) {
      case 'medicine_bottle':
        return Icons.medical_services;
      case 'local_pharmacy':
        return Icons.local_pharmacy;
      case 'prescription':
        return Icons.receipt_long;
      case 'schedule':
        return Icons.schedule;
      case 'support_agent':
        return Icons.support_agent;
      default:
        return Icons.info;
    }
  }

  @override
  String toString() {
    return 'Tip(title: $title, content: $content, icon: $icon)';
  }
}
