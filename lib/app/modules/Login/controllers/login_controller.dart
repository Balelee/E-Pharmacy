import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/token.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/Login/views/login_content_view.dart';
import 'package:pharmix/app/modules/Login/views/splash_view_view.dart';
import 'package:pharmix/app/modules/client/home/controllers/profile_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import '../../../utils/form_helper.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());
  SocketController socketController = Get.find<SocketController>();
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  final emailphoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  var isPasswordHidden = true.obs;
  var isReady = false.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> preloadLogo() async {
    await precacheImage(
      const AssetImage('assets/images/app-icone.png'),
      size: const Size(45, 45),
      Get.context!,
    );
    isReady.value = true;
  }

  Rx<Widget> changeContent = Rx<Widget>(Container());
  @override
  void onInit() {
    super.onInit();
    changeContent.value = SplashViewView();
    changeScreen();
    // emailphoneController.text = "54738460";
    // passwordController.text = "adminadmin";
    // emailphoneController.text = "+22675572009";
    // passwordController.text = "000000001";
    // emailphoneController.text = "74572004";
    // passwordController.text = "00000002";
    emailphoneController.text = "75572006";
    passwordController.text = "00000000";
    preloadLogo();
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
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
      // changeContent.value = LoginContentView();
    });
  }

  Future<void> checkLoginStatus() async {
  final userRepo = Get.find<UserRepository>();
  final hasUser = await userRepo.hasUser();

  if (hasUser) {
    final user = await userRepo.getUser();
    final token = Token.getAuthToken();

    if (user != null && token.isNotEmpty) {
      _redirectUser(user);
      return;
    }
  }
  changeContent.value = LoginContentView();
}


  void login() async {
    if (!loginFormkey.currentState!.validate()) return;
    User? user = await authProvider.login(
      email: emailphoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (user != null) {
      if (Get.isRegistered<UserController>()) {
        Get.delete<UserController>();
      }
      Get.put(UserController(Get.find<UserRepository>()));
      Get.put(ProfileController());
      await UserController.to.affectToCurrentUser(user);
      NavigationController.to.currentIndex.value = 0;
      _redirectUser(user);
    }
  }

  Future<void> _redirectUser(User user) async {
    switch (user.type) {
      case 'client':
        await socketController.connectToSocket(user: user);
        Get.offAllNamed(AppPages.BASE, arguments: user);
        break;
      case 'pharmacien':
        await socketController.connectToSocket(user: user);
        Get.offAllNamed(AppPages.PHARMACIEN, arguments: user);
        break;
      case 'admin':
        Get.offAllNamed(AppPages.ADMINHOME, arguments: user);
        break;
      default:
    }
  }
}
