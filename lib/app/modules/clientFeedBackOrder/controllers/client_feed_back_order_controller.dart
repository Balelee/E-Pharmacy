import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';

class ClientFeedBackOrderController extends GetxController {

    final orders = <OrderPharmacy>[].obs;
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

  void addOrder(OrderPharmacy orderPharmacy) {
    orders.insert(0, orderPharmacy);   }

  
  
}
