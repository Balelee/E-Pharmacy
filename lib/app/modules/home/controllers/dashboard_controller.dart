import 'package:e_pharma/app/cummon/controllers/user_controller.dart';
import 'package:e_pharma/app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Get the UserController instance
  final UserController userController = Get.find<UserController>();

  // Reactive values
  final ScrollController scrollController = ScrollController();
  RxInt notificationCount = RxInt(3);

  // Computed user properties
  String get userName =>
      userController.user?.username ??
      '${userController.user?.firstname ?? ''} ${userController.user?.lastname ?? ''}'
          .trim();

  String get userEmail => userController.user?.email ?? 'No email';
  String? get userAvatar => null;

  var user = User(
      id: 1,
      username: "Issiaka Ouedraogo",
      firstname: "Issiaka",
      lastname: "OUEDRAOGO",
      phone: "77890534",
      birthdate: "17/03/2004",
      birthplace: "Aboisso",
      email: "issa@gmail.com");
  @override
  void onInit() {
    super.onInit();
    userController.userRx.value = user;
    // ever(userController.userRx, (_) => update());
    // print("userName");
    // print(userName);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("userName");
    print(userName);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
