import 'package:get/get.dart';

import '../controllers/client_order_list_controller.dart';

class ClientOrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientOrderListController>(
      () => ClientOrderListController(),
    );
  }
}
