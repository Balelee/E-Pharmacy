import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/modules/Login/views/login_content_view.dart';
import 'package:pharmix/app/modules/Login/views/splash_view_view.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import '../../../utils/form_helper.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
// form controllers
  final emailphoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  // Reactive variable to handle password visibility
  var isPasswordHidden = true.obs;
  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Rx<Widget> changeContent = Rx<Widget>(Container());
  @override
  void onInit() {
    super.onInit();
    changeContent.value = SplashViewView();
    changeScreen();
    emailphoneController.text = "54738460";
    passwordController.text = "adminadmin";
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  Future<void> changeScreen() async {
    Future.delayed(Duration(seconds: 8), () {
      changeContent.value = LoginContentView();
    });
  }

  void login() async {
    if (!loginFormkey.currentState!.validate()) return;
    User? authMessage = await authProvider.login(
      email: emailphoneController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (authMessage != null) {
      Get.toNamed(AppPages.BASE, arguments: authMessage);
    }
  }
}
