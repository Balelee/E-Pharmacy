import 'package:e_pharma/app/modules/Login/views/login_content_view.dart';
import 'package:e_pharma/app/modules/Login/views/splash_view_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/form_helper.dart';

class LoginController extends GetxController {
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
  RxString contryCode = '+225'.obs;
  @override
  void onInit() {
    super.onInit();
    animateContent.value = SplashViewView();
    changeScreen();
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
    Future.delayed(Duration(seconds: 3), () {
      animateContent.value = LoginContentView();
    });
  }
}
