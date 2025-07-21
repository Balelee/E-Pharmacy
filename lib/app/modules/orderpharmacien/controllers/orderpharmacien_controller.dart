import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';

class OrderpharmacienController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  final orders = <Order>[].obs;
  final RxBool showToast = true.obs;


    void loadOrdersData() async {
    orders.value = await produitProvider.getOrdersCommand() ?? [];
  }

  @override
  void onInit() {
    super.onInit();
    loadOrdersData();
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
