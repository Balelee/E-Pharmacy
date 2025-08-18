import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/Login/controllers/login_controller.dart';
import 'package:pharmix/app/utils/helpers/treadloader_helper.dart';

class SplashViewView extends GetView<LoginController> {
  const SplashViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isReady.value) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.shrink(),
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/app-icone.png',
                  width: 45,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 15),
              ThreeDotsLoader(
                length: 5,
              ),
            ],
          ),
        ),
      );
    });
  }
}
