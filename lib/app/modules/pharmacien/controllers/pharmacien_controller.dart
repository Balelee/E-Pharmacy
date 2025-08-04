import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/providers/tip_provider.dart';

class PharmacienController extends GetxController {
  RxInt notificationCount = RxInt(3);
  final TipProvider tipProvider = TipProvider();
  final ScrollController scrollController = ScrollController();
  final user = UserController.to;
  RxList<Tip> tips = <Tip>[].obs;
  static NavigationController get to => Get.find();
  var currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  void changePage(int index) {
    currentIndex.value = index;
  }

  // String get pharmacieName {
  //   final currentUser = user.user;
  //   if (currentUser == null || currentUser.userStatus != 'pharmacien') {
  //     return 'Non disponible';
  //   }
  //   return currentUser.pharmacieName ?? 'Non disponible';
  // }

  Future<void> fetchTips() async {
    final Rtips = await tipProvider.loadTipsData();
    tips.value = Rtips;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTips();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
