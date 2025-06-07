import 'package:e_pharma/app/config/env.dart';
import 'package:e_pharma/app/cummon/controllers/language_controller.dart';
import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/cummon/controllers/socket_controller.dart';
import 'package:e_pharma/app/cummon/controllers/user_controller.dart';
import 'package:e_pharma/app/data/repositories/user_repository.dart';
import 'package:e_pharma/app/modules/home/controllers/cart_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:e_pharma/app/modules/searchproduct/controllers/searchproduct_controller.dart';
import 'package:e_pharma/app/utils/services/localization_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DependencieInjection {
  static Future<void> init() async {
    await GetStorage.init();
    await dotenv.load(
        fileName: Env.isLocal ? Env.developement : Env.production);
    Get.put(NavigationController());
    Get.put(LocalizationService());
    Get.put(LanguageController());
    Get.put(SocketController());
    Get.put(CartController());
    Get.lazyPut(() => UserRepository());
    Get.lazyPut(() => UserController(Get.find<UserRepository>()));
    Get.lazyPut<SearchproductController>(() => SearchproductController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
