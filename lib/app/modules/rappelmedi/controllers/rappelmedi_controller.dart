import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RappelmediController extends GetxController {
  final DateTime currentDate = DateTime.now();
  late final int daysInMonth;
  late final ScrollController scrollController;
  RxString selectedForm = "".obs;

  RxList<Map<String, dynamic>> takeProductS = [
    {
      "productName": "Doliprane",
      "form": "Comprimé",
      "takeHour": "10:30",
      "takeQuantity": "1 comprimé",
      "durationDays": 5,
      "startDate": "2025-06-13",
      "notes": "",
    },
    {
      "productName": "Diclore",
      "form": "Sirop",
      "takeHour": "23:00",
      "takeQuantity": "2 cuillères",
      "durationDays": 7,
      "startDate": "2025-06-13",
      "notes": "",
    },
    {
      "productName": "Paracetamol",
      "form": "Injection",
      "takeHour": "07:45",
      "takeQuantity": "1 par jour",
      "durationDays": 3,
      "startDate": "2025-06-13",
      "notes": "À administrer par une infirmière",
    },
    {
      "productName": "Amoxiline",
      "form": "Comprimé",
      "takeHour": "17:45",
      "takeQuantity": "2 par jour",
      "durationDays": 3,
      "startDate": "2025-06-13",
      "notes": "À administrer par une infirmière",
    }
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    daysInMonth = lastDayOfMonth.day;

    scrollController = ScrollController(
      initialScrollOffset: 0,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
