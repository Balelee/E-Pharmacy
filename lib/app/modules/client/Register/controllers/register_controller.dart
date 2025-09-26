import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/form_helper.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> signUpFormkey = GlobalKey<FormState>();
  final AuthProvider authProvider = Get.put(AuthProvider());
  final dateMask = MaskTextInputFormatter(mask: '##-##-####');
  // form controllers
  final phoneController = FormHelper.getController();
  final usernameController = FormHelper.getController();
  final firstnameController = FormHelper.getController();
  final lastnameController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  final emailController = FormHelper.getController();
  final birthdateController = FormHelper.getController();
  final birthplaceController = FormHelper.getController();
  User? user;
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
    DialogHelper.showLoading(
      message: "Patienter...",
      noBkgColor: false,
      colorProgress: AppColors.primary,
    );
    final user = User(
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
      username: usernameController.text.trim(),
      firstname: firstnameController.text.trim(),
      lastname: lastnameController.text.trim(),
      email: emailController.text.trim(),
      birthdate: birthdateController.text.trim(),
      birthplace: birthplaceController.text.trim(),
    );
    final newUser = await authProvider.signUp(user);
    DialogHelper.hideLoading();
    if (newUser != null) {
      Get.toNamed(AppPages.LOGINCONTENT);
    }
  }
}
