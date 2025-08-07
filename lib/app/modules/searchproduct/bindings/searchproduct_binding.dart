import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/cart_controller.dart';

import '../controllers/searchproduct_controller.dart';

class SearchproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchproductController>(
      () => SearchproductController(),
    );
    Get.lazyPut<CartController>(() => CartController());
  }
}
