import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/providers/tip_provider.dart';
import 'package:pharmix/app/data/repositories/notification_app.dart';
import '../../../utils/helpers/dialog_helper.dart';
import 'package:timezone/timezone.dart' as tz;

class RappelmediController extends GetxController {
  final DateTime currentDate = DateTime.now();
  late final int daysInMonth;
  final RxBool showToast = true.obs;
  final pills = <PillRemember>[].obs;
  final TipProvider pillService = TipProvider();
  late final ScrollController scrollController;
  RxString selectedForm = "".obs;
  RxString selectedTime = "Quotidien".obs;
  RxList<String> timeOptions = ["Quotidien", "Hebdomadaire", "Mensuel"].obs;
  final TextEditingController pillnameController = TextEditingController();
  final TextEditingController pilltypeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();
  final NotificationService notificationService = NotificationService();

  @override
  void onInit() async {
    super.onInit();
    final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    daysInMonth = lastDayOfMonth.day;
    scrollController = ScrollController(
      initialScrollOffset: 0,
    );
    await notificationService.initialize();
    await notificationService.requestPermission();
    await getRemenbers();
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

  void clearFields() {
    pillnameController.clear();
    dateController.clear();
    timeController.clear();
    selectedForm.value = "";
    selectedTime.value = "Quotidien";
  }

  Future<void> getRemenbers() async {
    try {
      final result = await pillService.loadPillRemembers();
      pills.assignAll(result);
      for (var pill in result) {
        final datePart = DateFormat('yyyy-MM-dd').format(pill.startDate);
        final timePart = pill.reminderTime;
        final dateTimeString = "$datePart $timePart:00";
        final scheduledDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(dateTimeString, true)
            .toLocal();
        final scheduledDateTZ = tz.TZDateTime.from(scheduledDate, tz.local);
        print("🕒 Date textuelle : $dateTimeString");
        print("🗓️ Date finale planifiée : $scheduledDateTZ");
        print("🕒 Maintenant (local TZ) : ${tz.TZDateTime.now(tz.local)}");

        if (scheduledDateTZ.isBefore(tz.TZDateTime.now(tz.local))) {
          print("❌ Notification ignorée, date dépassée : $scheduledDateTZ");
        } else {
          await notificationService.scheduleNotification(
            id: pill.id!,
            title: 'Rappel médicament',
            body: 'Il est temps de prendre ${pill.medicineName}',
            scheduledDate: scheduledDateTZ,
            frequency: pill.frequency,
          );
        }
      }
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur : $e");
    }
  }

  Future<void> submitPill(Map<String, dynamic> formData) async {
    try {
      final result = await pillService.storeRemenber(data: formData);
      if (result != null) {
        pills.add(result);
        final datePart = DateFormat('yyyy-MM-dd').format(result.startDate);
        final timePart = result.reminderTime;
        final dateTimeString = "$datePart $timePart:00";

        final scheduledDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(dateTimeString, true)
            .toLocal();
        final scheduledDateTZ = tz.TZDateTime.from(scheduledDate, tz.local);
        print("🕒 Date textuelle : $dateTimeString");
        print("🗓️ Date finale planifiée : $scheduledDateTZ");
        print("🕒 Maintenant (local TZ) : ${tz.TZDateTime.now(tz.local)}");
        if (scheduledDateTZ.isBefore(tz.TZDateTime.now(tz.local))) {
          print("❌ Notification ignorée, date dépassée : $scheduledDateTZ");
        } else {
          await notificationService.scheduleNotification(
            id: result.id!,
            title: 'Rappel médicament',
            body: 'Il est temps de prendre ${result.medicineName}',
            scheduledDate: scheduledDateTZ,
            frequency: result.frequency,
          );
        }

        Get.snackbar("Succès", "Rappel enregistré avec succès",
            snackPosition: SnackPosition.TOP);
      } else {
        DialogHelper.showErrorSnackbar(message: "fetching error:");
      }
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur : $e");
    } finally {
      DialogHelper.hideLoading();
    }
  }
}
