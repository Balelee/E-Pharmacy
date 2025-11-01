import 'package:get/get.dart';
import '../controllers/client_feed_back_request_controller.dart';

class ClientFeedBackRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientFeedBackRequestController>(
      () => ClientFeedBackRequestController(),
    );
  }
}
