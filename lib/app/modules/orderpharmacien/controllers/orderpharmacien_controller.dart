import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class OrderpharmacienController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  final orders = <Order>[].obs;
  final RxBool showToast = true.obs;
  final RxString selectedStatus = ''.obs;

  // void loadOrdersData() async {
  //   orders.value = await produitProvider.getOrdersCommand() ?? [];
  // }

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
    // loadOrdersData();
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
