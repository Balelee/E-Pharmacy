import 'package:e_pharma/app/cummon/controllers/user_controller.dart';
import 'package:e_pharma/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import 'package:e_pharma/app/modules/home/controllers/cart_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/dashboard_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => UserRepository());
    Get.lazyPut(() => UserController(Get.find<UserRepository>()));
  }
}
