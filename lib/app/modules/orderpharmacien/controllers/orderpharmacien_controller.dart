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
