import 'package:get/get.dart';

import '../controllers/searchproduct_controller.dart';

class SearchproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchproductController>(
      () => SearchproductController(),
    );
  }
}
