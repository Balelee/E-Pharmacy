import 'package:e_pharma/app/data/models/cart_item.dart';
import 'package:e_pharma/app/data/models/order.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  Rxn<Order> order = Rxn();
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
          sum! + (int.parse(item.priceUnitaire) * int.parse(item.quantity)))??0.0;

  double fraisLivraison = 2050;
  double get totalPrice => totalCommande + fraisLivraison;
}
