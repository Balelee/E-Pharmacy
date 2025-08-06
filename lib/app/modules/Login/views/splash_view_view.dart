import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/Login/controllers/login_controller.dart';

class SplashViewView extends GetView<LoginController> {
  const SplashViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/sflogo.png',
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            Image.asset(
              'assets/images/loading.gif',
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
