import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/tip_provider.dart';

class DashboardController extends GetxController {
  // Get the UserController instance
  final UserController userController = Get.find<UserController>();
  final TipProvider tipProvider = TipProvider();
  RxList<Tip> tips = <Tip>[].obs;

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
      email: "issa@gmail.com",
      address: "Ouagadougou, Belle ville",
      joinedAt: 'April 2025');

  // recuperer les conseils du jour
  Future<void> fetchTips() async {
    final Rtips = await tipProvider.loadTipsData();
    tips.value = Rtips;
  }

  @override
  void onInit() {
    super.onInit();
    userController.updateUser(user);
    ever(userController.userRx, (_) => update());
    fetchTips();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
