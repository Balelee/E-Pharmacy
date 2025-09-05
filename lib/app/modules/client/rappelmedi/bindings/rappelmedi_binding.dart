import 'package:get/get.dart';

import '../controllers/rappelmedi_controller.dart';

class RappelmediBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RappelmediController>(
      () => RappelmediController(),
    );
  }
}
