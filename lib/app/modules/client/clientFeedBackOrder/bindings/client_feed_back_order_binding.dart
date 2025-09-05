import 'package:get/get.dart';
import '../controllers/client_feed_back_order_controller.dart';

class ClientFeedBackOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientFeedBackOrderController>(
      () => ClientFeedBackOrderController(),
    );

  }
}
