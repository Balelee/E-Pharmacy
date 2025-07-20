import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/enums/orderstatus.dart';
import 'package:pharmix/app/data/models/order.dart';

class OrderpharmacienController extends GetxController {

  final orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders(); 
  }

  void fetchOrders() {
    // Simule ou récupère via API
    orders.value = [
      Order(
        id: 1,
        amount: "15000",
        status: OrderStatus.traite,
        statusColor: Colors.green,
        orderDetails: [],
      ),
      Order(
        id: 2,
        amount: "8000",
        status: OrderStatus.enattent,
        statusColor: Colors.orange,
        orderDetails: [],
      ),
    ];
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
