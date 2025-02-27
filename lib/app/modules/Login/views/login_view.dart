import 'package:e_pharma/app/modules/Login/views/splash_view_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (widget, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 0.3),
                  end: Offset.zero, 
                ).animate(animation),
                child: widget,
              ),
            );
          },
          child: controller.animateContent.value,
        ),
      ),
    );
  }
}
