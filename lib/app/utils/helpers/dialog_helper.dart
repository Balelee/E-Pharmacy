import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../themes/app_colors.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show loading
  static void showLoading({String? message, bool? noBkgColor}) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: noBkgColor! ? Colors.transparent : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
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

  static void displayErrorDialog({required String message}) {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.warning,
      titleColor: AppColors.error,
      confirmBtnColor: AppColors.background,
      title: 'error_title'.tr,
      text: message.tr,
    );
  }

  static void displayInfoDialog(
      {required String message,
      void Function()? onConfirmBtnTap,
      void Function()? onCancelBtnTap,
      String confirmBtnText = 'new',
      String cancelBtnText = 'cancel',
      bool barrierDismissible = true}) {
    QuickAlert.show(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        type: QuickAlertType.info,
        titleColor: AppColors.info,
        confirmBtnColor: AppColors.background,
        onConfirmBtnTap: onConfirmBtnTap,
        onCancelBtnTap: onCancelBtnTap,
        title: 'Information'.tr,
        text: message.tr,
        confirmBtnText: confirmBtnText.tr,
        cancelBtnText: cancelBtnText.tr,
        showCancelBtn: true);
  }

  static void displaySuccesDialog(
      {required String message,
      void Function()? onConfirmBtnTap,
      bool barrierDismissible = true}) {
    QuickAlert.show(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      type: QuickAlertType.success,
      titleColor: AppColors.success,
      confirmBtnColor: AppColors.background,
      text: message.tr,
      onConfirmBtnTap: onConfirmBtnTap,
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
            child: Text('no'.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(
              'yes'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.background),
            ),
          ),
        ],
      ),
    );
  }
}
