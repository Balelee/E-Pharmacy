import 'package:e_pharma/app/config/env.dart';
import 'package:e_pharma/app/cummon/controllers/language_controller.dart';
import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/cummon/controllers/user_controller.dart';
import 'package:e_pharma/app/data/repositories/user_repository.dart';
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
    Get.lazyPut(() => UserRepository());
    Get.lazyPut(() => UserController(Get.find<UserRepository>()));
  }
}
