import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class PillRemember {
  final int? id;
  final int? userId;
  final String medicineName;
  final DateTime startDate;
  final String reminderTime;
  final String form;
  final String frequency;

  PillRemember({
    this.id,
    this.userId,
    required this.medicineName,
    required this.startDate,
    required this.reminderTime,
    required this.form,
    required this.frequency,
  });

  factory PillRemember.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    try {
      parsedDate = DateFormat('dd-MM-yyyy').parseStrict(json['start_date']);
    } catch (e) {
      parsedDate = DateTime.parse(json['start_date']);
    }
    return PillRemember(
      id: json['id'],
      userId: json['user_id'],
      medicineName: json['medicine_name'],
      startDate: parsedDate,
      reminderTime: json['reminder_time'],
      form: json['form'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      'medicine_name': medicineName,
      'start_date': startDate.toIso8601String(),
      'reminder_time': reminderTime,
      'form': form,
      'frequency': frequency,
    };
  }
}
