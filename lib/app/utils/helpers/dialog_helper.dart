import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../themes/app_colors.dart';

class DialogHelper {
  // Show an error snackbar
  static void showErrorSnackbar(
      {String title = 'Error', required String message}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      isDismissible: false,
      icon: IconButton(
        onPressed: () => Get.closeCurrentSnackbar(),
        icon: const Icon(Icons.cancel_rounded, color: Colors.white),
      ),
      duration: const Duration(seconds: 30),
    );
  }

  //show loading
  static void showLoading(
      {String? message,
      bool? noBkgColor,
      Color? colorProgress,
      TextStyle? messageStyle}) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: noBkgColor! ? Colors.transparent : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: colorProgress,
              ),
              const SizedBox(height: 8),
              Text(
                message ?? 'Loading...',
                style: messageStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  // Show a success snackbar
  static void showSuccessSnackbar(
      {String title = 'Success', required String message}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 20),
    );
  }

  // Show an info snackbar
  static void showInfoSnackbar(
      {String title = 'Info', required String message, int seconds = 0}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: seconds),
    );
  }

  // Show a confirmation dialog
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    required Function() onConfirm,
  }) {
    return Get.defaultDialog(
      title: title.tr,
      middleText: message.tr,
      textConfirm: 'Yes'.tr,
      textCancel: 'No'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
        onConfirm();
      },
      onCancel: () => Get.back(result: false),
    );
  }

  static void displayNoInternetDialog(
      {required String message,
      void Function()? onConfirmBtnTap,
      String? tiltle,
      bool barrierDismissible = true}) {
    QuickAlert.show(
        context: Get.context!,
        barrierDismissible: false,
        type: QuickAlertType.warning,
        titleColor: AppColors.info,
        confirmBtnColor: AppColors.primary,
        title: tiltle?.tr,
        text: message.tr,
        cancelBtnText: "OK",
        onConfirmBtnTap: onConfirmBtnTap);
  }

  static Future<dynamic> confirmationDialog(
      {required String title,
      required String message,
      required Function() onConfirm,
      required Function() onCancel}) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 5.0),
        actionsPadding: const EdgeInsets.symmetric(vertical: 0.0),
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(LocaleKeys.buttons_no.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(
              LocaleKeys.buttons_yes.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Get.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
