import 'package:get/get.dart';

import 'package:e_pharma/app/modules/home/controllers/cart_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
