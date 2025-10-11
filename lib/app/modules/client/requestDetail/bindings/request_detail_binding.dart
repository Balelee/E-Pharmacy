import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/requestDetail/controllers/request_detail_controller.dart';


class RequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestDetailController>(
      () => RequestDetailController(),
    );
  }
}
