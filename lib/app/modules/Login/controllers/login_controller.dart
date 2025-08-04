import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/Login/views/login_content_view.dart';
import 'package:pharmix/app/modules/Login/views/splash_view_view.dart';
import 'package:pharmix/app/modules/home/controllers/profile_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import '../../../utils/form_helper.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  final emailphoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  var isPasswordHidden = true.obs;
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
    DialogHelper.showLoading(
        message: "Patienter...",
        noBkgColor: false,
        colorProgress: AppColors.primary);
    if (!loginFormkey.currentState!.validate()) return;
    User? user = await authProvider.login(
      email: emailphoneController.text.trim(),
      password: passwordController.text.trim(),
    );
    DialogHelper.hideLoading();
    if (user != null) {
      if (Get.isRegistered<UserController>()) {
        Get.delete<UserController>();
      }
      Get.put(UserController(Get.find<UserRepository>()));
      Get.put(ProfileController());
      await UserController.to.login(user);
      NavigationController.to.currentIndex.value = 0;
      if (user.userStatus == 'client') {
        Get.toNamed(AppPages.BASE, arguments: user);
      } else if (user.userStatus == 'pharmacien') {
        Get.toNamed(AppPages.PHARMACIEN, arguments: user);
      }
    }
  }
}
