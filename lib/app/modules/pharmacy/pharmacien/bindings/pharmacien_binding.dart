import 'package:get/get.dart';

import '../controllers/pharmacien_controller.dart';

class PharmacienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacienController>(
      () => PharmacienController(),
    );
  }
}
