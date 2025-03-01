import 'package:e_pharma/app/modules/Login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginContentView extends GetView<LoginController> {
  const LoginContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Login content "),
      ),
    );
  }
}
