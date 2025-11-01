import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/ClientRequestList/controllers/client_request_list_controller.dart';
class ClientRequestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientRequestListController>(
      () => ClientRequestListController(),
    );
  }
}
