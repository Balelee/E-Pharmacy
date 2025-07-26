import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/providers/tip_provider.dart';

class PharmacienController extends GetxController {
  RxInt notificationCount = RxInt(3);
  final TipProvider tipProvider = TipProvider();
  final ScrollController scrollController = ScrollController();
  RxList<Tip> tips = <Tip>[].obs;

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
