import 'package:e_pharma/app/modules/Login/views/splash_view_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  Rx<Widget> animateContent = Rx<Widget>(Container());
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
      animateContent.value = Center(child: Text("Login Page"));
    });
  }
}
