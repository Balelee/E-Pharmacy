import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmix/app/config/env.dart';
import 'package:pharmix/app/cummon/controllers/language_controller.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/client/clientFeedBackOrder/controllers/client_feed_back_order_controller.dart';
import 'package:pharmix/app/modules/client/home/controllers/product_controller.dart';
import 'package:pharmix/app/modules/client/home/controllers/profile_controller.dart';
import 'package:pharmix/app/modules/client/paiement/controllers/paiement_controller.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/modules/client/searchproduct/controllers/searchproduct_controller.dart';
import 'package:pharmix/app/utils/services/localization_service.dart';

class DependencieInjection {
  static Future<void> init() async {
    await GetStorage.init();
    await dotenv.load(
        fileName: Env.isLocal ? Env.developement : Env.production);
    Get.put(NavigationController());
    Get.put(LocalizationService());
    Get.put(LanguageController());
    Get.lazyPut(() => PharmacienController());
    Get.put(SocketController());
    Get.put(PaiementController());
    Get.lazyPut(() => UserRepository());
    Get.put(UserController(UserRepository()));
    Get.lazyPut(() => ProfileController());
    Get.lazyPut<SearchproductController>(() => SearchproductController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.put(ClientFeedBackOrderController());
  }
}
