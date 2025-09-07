import 'package:get/get.dart';

import '../controllers/receiptpay_controller.dart';

class ReceiptpayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptpayController>(
      () => ReceiptpayController(),
    );
  }
}
