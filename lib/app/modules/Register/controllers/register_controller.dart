import 'package:e_pharma/app/data/models/auth_message.dart';
import 'package:e_pharma/app/data/providers/auth_provider.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/utils/form_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> signUpFormkey = GlobalKey<FormState>();
  final AuthProvider authProvider = Get.put(AuthProvider());
  // form controllers
  final phoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  final confirmPasswordController = FormHelper.getController();
  // Reactive variable to handle password visibility
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  RxString contryCode = '+226'.obs;
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

  void signUp() async {
    if (!signUpFormkey.currentState!.validate()) return;
    AuthMessage? authMessage = await authProvider.signUp(
        phone: contryCode.value + phoneController.text.trim(),
        password: passwordController.text.trim());
    if (authMessage != null) {
      Get.toNamed(AppPages.OTP, arguments: authMessage);
    }
  }
}
