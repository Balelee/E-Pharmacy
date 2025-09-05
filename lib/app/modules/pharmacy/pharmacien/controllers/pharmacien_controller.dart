import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/auxiliaire_order.dart';
import 'package:pharmix/app/data/providers/auxilliaire_provider.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class PharmacienController extends GetxController {
  AuxilliaireProvider auxilliaireProvider = AuxilliaireProvider();
  RxInt notificationCount = RxInt(3);
  final RxBool showToast = true.obs;
  final ScrollController scrollController = ScrollController();
  final user = UserController.to;
  static NavigationController get to => Get.find();
  var currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  final ProductProvider produitProvider = ProductProvider();
  final RxList<AuxiliaireOrder> orders = <AuxiliaireOrder>[].obs;
  final RxString selectedStatus = ''.obs;
  void changePage(int index) {
    currentIndex.value = index;
  }

  void loadOrdersData() async {
    orders.value = await produitProvider.getOrdersPharmacies() ?? [];
  }

  Future<void> fetchOrdersByStatus(String status) async {
    DialogHelper.showLoading(
        message: "Patienter...",
        noBkgColor: false,
        colorProgress: Colors.green);
    try {
      selectedStatus.value = status;
      final result = await produitProvider.getOrdersByStatus(status);
      orders.assignAll(result);
      DialogHelper.hideLoading();
    } catch (e) {
      DialogHelper.hideLoading();
      print("Erreur lors de la récupération des commandes : $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (orders.isEmpty) {
      loadOrdersData();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> storeOrderResponse(
      {required int orderId, required Map<String, dynamic> data}) async {
    bool response =
        await auxilliaireProvider.storeResponse(orderId: orderId, data: data);

    if (response) {
      final index = orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        orders.removeAt(index);
      }
    }
  }
}
