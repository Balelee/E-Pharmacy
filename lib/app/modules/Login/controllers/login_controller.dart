import 'package:e_pharma/app/data/models/auth_message.dart';
import 'package:e_pharma/app/data/providers/auth_provider.dart';
import 'package:e_pharma/app/modules/Login/views/login_content_view.dart';
import 'package:e_pharma/app/modules/Login/views/splash_view_view.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/form_helper.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
// form controllers
  final phoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  // Reactive variable to handle password visibility
  var isPasswordHidden = true.obs;
  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Rx<Widget> animateContent = Rx<Widget>(Container());
  RxString contryCode = '+226'.obs;
  @override
  void onInit() {
    super.onInit();
    animateContent.value = SplashViewView();
    changeScreen();
    phoneController.text = "53380701";
    passwordController.text = "adminadmin";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> changeScreen() async {
    Future.delayed(Duration(seconds: 1), () {
      animateContent.value = LoginContentView();
    });
  }

  void login() async {
    if (!loginFormkey.currentState!.validate()) return;
    AuthMessage? authMessage = await authProvider.login(
      phone: contryCode.value + phoneController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (authMessage != null) {
      Get.toNamed(AppPages.OTP, arguments: authMessage);
    }
  }


}
