import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import '../../../utils/form_helper.dart';

class OtpController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());
  final otpController = FormHelper.getController();
  GlobalKey<FormState> otpFormkey = GlobalKey<FormState>();
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

  void verifyOtp({required String? phone}) async {
    if (!otpFormkey.currentState!.validate()) return null;
    if (phone != null) {
      bool isVerified =
          await authProvider.verifyOtp(otp: otpController.text, phone: phone);
      if (isVerified) {
        Get.offAllNamed(AppPages.BASE);
      }
    }
  }
}
