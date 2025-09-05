import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/providers/tip_provider.dart';
import 'package:pharmix/app/data/repositories/notification_app.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/showDialog.dart';
import 'package:pharmix/generated/locales.g.dart';
import '../../../../utils/helpers/dialog_helper.dart';
import 'package:timezone/timezone.dart' as tz;

class RappelmediController extends GetxController {
  final DateTime currentDate = DateTime.now();
  late final int daysInMonth;
  final RxBool showToast = true.obs;
  final pills = <PillRemember>[].obs;
  final List<TimeOfDay> selectedTimes = [];
  final TipProvider pillService = TipProvider();
  late final ScrollController scrollController;
  RxString selectedForm = "".obs;
  RxString selectedTime = LocaleKeys.quotien.tr.obs;
  RxList<String> timeOptions = [
    LocaleKeys.quotien.tr,
    LocaleKeys.hebdomadaire.tr,
    LocaleKeys.mensuel.tr
  ].obs;
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
    selectedTime.value = LocaleKeys.quotien.tr;
  }

  Future<void> getRemenbers() async {
    try {
      final result = await pillService.loadPillRemembers();
      pills.assignAll(result);
      for (var pill in result) {
        final datePart = DateFormat('yyyy-MM-dd').format(pill.startDate);
        final List<String> timeParts = pill.reminderTime.split(',');
        for (final timePart in timeParts) {
          final dateTimeString = "$datePart $timePart:00";
          final scheduledDate = DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(dateTimeString, true)
              .toLocal();
          final scheduledDateTZ = tz.TZDateTime.from(scheduledDate, tz.local);
          if (scheduledDateTZ.isAfter(tz.TZDateTime.now(tz.local))) {
            await notificationService.scheduleNotification(
              id: pill.id! + timeParts.indexOf(timePart),
              title: LocaleKeys.msg_prise_tile.tr,
              body: '${LocaleKeys.msg_body_prise.tr}: ${pill.medicineName}',
              scheduledDate: scheduledDateTZ,
              frequency: pill.frequency,
            );
          }
        }
      }
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur : $e");
    }
  }

  Future<void> submitPill(Map<String, dynamic> formData) async {
    try {
      final reminderTimeList = selectedTimes
          .map((t) =>
              "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}")
          .toList();
      formData['reminder_time'] = reminderTimeList.join(',');
      final result = await pillService.storeRemenber(data: formData);
      if (result != null) {
        pills.add(result);
        for (final timeString in reminderTimeList) {
          final datePart = DateFormat('yyyy-MM-dd').format(result.startDate);
          final dateTimeString = "$datePart $timeString:00";
          final scheduledDate = DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(dateTimeString, true)
              .toLocal();
          final scheduledDateTZ = tz.TZDateTime.from(scheduledDate, tz.local);
          if (scheduledDateTZ.isAfter(tz.TZDateTime.now(tz.local))) {
            await notificationService.scheduleNotification(
              id: result.id! + reminderTimeList.indexOf(timeString),
              title: LocaleKeys.msg_prise_tile.tr,
              body: '${LocaleKeys.msg_body_prise.tr}: ${result.medicineName}',
              scheduledDate: scheduledDateTZ,
              frequency: result.frequency,
            );
          }
        }
        Get.snackbar(LocaleKeys.success.tr, LocaleKeys.success_msg_snackber.tr,
            snackPosition: SnackPosition.TOP, colorText: AppColors.background);
      } else {
        DialogHelper.showErrorSnackbar(message: "fetching error:");
      }
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur : $e");
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<void> cancelAllNotificationsForPill(PillRemember reminder) async {
    final timeParts = reminder.reminderTime.split(',');
    for (final timePart in timeParts) {
      final notificationId = reminder.id! + timeParts.indexOf(timePart);
      await notificationService.cancelNotification(notificationId);
    }
  }

  void onDeletePressed(PillRemember reminder) async {
    final confirmed = await ShowDialog.showdialog(
        title: CustomText(
          text: LocaleKeys.msg_delete.tr,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: CustomText(
          text: LocaleKeys.content_delete.tr,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        cancelButton: CustomButton.primaryButton(
          backgroundColor: AppColors.error,
          padding: EdgeInsets.symmetric(horizontal: 30),
          buttonTitle: LocaleKeys.cancel.tr,
          textStyle: TextStyle(fontSize: 14, color: AppColors.background),
          onPressed: () => Navigator.pop(Get.context!, false),
        ),
        actionButton: CustomButton.primaryButton(
          padding: EdgeInsets.symmetric(horizontal: 30),
          buttonTitle: LocaleKeys.delete.tr,
          textStyle: TextStyle(fontSize: 14, color: AppColors.background),
          onPressed: () => Navigator.pop(Get.context!, true),
        ));
    if (confirmed == true) {
      await cancelAllNotificationsForPill(reminder);
      bool success = await pillService.deletePillRemember(reminder.id!);
      if (success) {
        pills.removeWhere((r) => r.id == reminder.id);
        update();
        DialogHelper.showSuccessSnackbar(
            message: LocaleKeys.success_delete_msg.tr);
      }
    }
  }
}
