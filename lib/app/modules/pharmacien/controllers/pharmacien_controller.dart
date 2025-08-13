import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class PharmacienController extends GetxController {
  RxInt notificationCount = RxInt(3);
  final RxBool showToast = true.obs;
  final ScrollController scrollController = ScrollController();
  final user = UserController.to;
  static NavigationController get to => Get.find();
  var currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  final ProductProvider produitProvider = ProductProvider();
  final orders = <Order>[].obs;
  final RxString selectedStatus = ''.obs;
  void changePage(int index) {
    currentIndex.value = index;
  }

  void loadOrdersData() async {
    orders.value = await produitProvider.getOrdersPharmacies() ?? [];
  }

  void updateOrderStatus(int orderId, String status) async {
    final updatedOrder = await produitProvider.updateOrderStatus(
      orderId: orderId,
      status: status,
    );
    if (updatedOrder != null) {
      int index = orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        orders[index] = updatedOrder;
        orders.refresh();
      }
    }
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
  }

  @override
  void onClose() {
    super.onClose();
  }
}
