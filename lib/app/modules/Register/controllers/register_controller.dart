import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/form_helper.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> signUpFormkey = GlobalKey<FormState>();
  final AuthProvider authProvider = Get.put(AuthProvider());
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
    DialogHelper.showLoading(
      message: "Patienter...",
      noBkgColor: false,
      colorProgress: AppColors.primary,
    );
    if (!signUpFormkey.currentState!.validate()) return;
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
    DialogHelper.hideLoading();
    final newUser = await authProvider.signUp(user);
    if (newUser != null) {
      if (newUser.userStatus == 'client') {
        Get.toNamed(AppPages.BASE, arguments: newUser);
      } else if (newUser.userStatus == 'pharmacien') {
        Get.toNamed(AppPages.PHARMACIEN, arguments: newUser);
      }
    }
  }
}
