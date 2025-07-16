import 'package:get/get.dart';

import '../controllers/clinique_controller.dart';

class CliniqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CliniqueController>(
      () => CliniqueController(),
    );
  }
}
