import 'package:e_pharma/app/modules/Login/controllers/login_controller.dart';
import 'package:e_pharma/app/widgets/country_code_box.dart';
import 'package:e_pharma/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/app_text_styles.dart';
import '../../../widgets/custom_text.dart';

class LoginContentView extends GetView<LoginController> {
  const LoginContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomText(
                    text: "Se connecter",
                    style: AppTextStyles.heading3,
                  ),
                ),
                CustomTextFormField(
                  controller: controller.phoneController,
                  labelText: "Téléphone",
                  prefix: contryCodeBox(selectedCode: controller.contryCode),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextFormField(
                    controller: controller.passwordController,
                    labelText: "Mot de passe",
                    prefix: Icon(Icons.lock),
                    obscureText: controller.isPasswordHidden.value,
                    suffix: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
