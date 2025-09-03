

import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order.dart';

class OrderDetailController extends GetxController {
  Rxn<Order> order = Rxn();
    RxString deliveryAdress = RxString("Abidjan, cocody");
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



  double get totalCommande => order.value?.orderDetails.fold(
      0,
      (sum, item) =>
          sum! + (int.parse(item.priceUnitaire.toString()) * int.parse(item.quantity.toString())))??0.0;

  double fraisLivraison = 2050;
  double get totalPrice => totalCommande + fraisLivraison;
}
