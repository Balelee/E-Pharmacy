import 'package:get/get.dart';

import '../controllers/orderpharmacien_controller.dart';

class OrderpharmacienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderpharmacienController>(
      () => OrderpharmacienController(),
    );
  }
}
