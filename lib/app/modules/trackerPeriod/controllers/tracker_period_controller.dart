import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrackerPeriodController extends GetxController {
  final List<DateTime> daysList = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  int daysUntilPeriod = 4;
  String get formattedDate {
    return DateFormat('EEE. d MMM', 'fr').format(DateTime.now());
  }

  final DateTime startMonth = DateTime.now();
  final RxInt monthCount = 12.obs;
  final RxSet<DateTime> selectedDays = <DateTime>{}.obs;
  final RxSet<DateTime> menstruationDays = <DateTime>{
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
  }.obs;
  final RxSet<DateTime> ovulationDays = <DateTime>{
    DateTime.now().add(const Duration(days: 10)),
  }.obs;
  List<DateTime> getDaysInMonth(DateTime month) {
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  List<String> weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Color getDayColor(DateTime day) {
    if (selectedDays.any((d) => isSameDay(d, day))) {
      return Colors.blue;
    } else if (menstruationDays.any((d) => isSameDay(d, day))) {
      return Colors.redAccent;
    } else if (ovulationDays.any((d) => isSameDay(d, day))) {
      return Colors.green;
    } else if (isSameDay(day, DateTime.now())) {
      return Colors.purple;
    } else {
      return AppColors.background;
    }
  }

  Color getNumberColor(DateTime day) {
    if (selectedDays.any((d) => isSameDay(d, day))) {
      return Colors.white;
    } else if (menstruationDays.any((d) => isSameDay(d, day))) {
      return Colors.white;
    } else if (ovulationDays.any((d) => isSameDay(d, day))) {
      return Colors.white;
    } else if (isSameDay(day, DateTime.now())) {
      return Colors.white;
    } else {
      return AppColors.primary;
    }
  }

  String getDayLabel(DateTime day) {
    if (menstruationDays.any((d) => isSameDay(d, day))) {
      return 'Menstrue';
    } else if (ovulationDays.any((d) => isSameDay(d, day))) {
      return 'Ovulation';
    } else {
      return '';
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
