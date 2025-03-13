import 'package:e_pharma/app/data/providers/auth_provider.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final AuthProvider authProvider = Get.put(AuthProvider());
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logOut() {
    authProvider.logout().then((value) {
      if (value) {
        Get.offAllNamed(AppPages.LOGINCONTENT);
      }
    });
  }
}
