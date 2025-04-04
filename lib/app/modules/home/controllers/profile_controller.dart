import 'package:e_pharma/app/data/providers/auth_provider.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final AuthProvider authProvider = Get.put(AuthProvider());
  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");
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

  void setLoading({String loadMessage = "Loading..."}) {
    isLoding.value = true;
    loadingMessage.value = loadMessage;
  }

  void stopLoading() {
    isLoding.value = false;
    loadingMessage.value = "Loading...";
  }

  void logOut() {
    DialogHelper.confirmationDialog(
        title: LocaleKeys.confirm_title.tr,
        message: LocaleKeys.logout_message.tr,
        onCancel: () {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        },
        onConfirm: () async {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          setLoading(loadMessage: '');
          await authProvider.logout().then((value) {
            if (value) {
              Get.offAllNamed(AppPages.LOGINCONTENT);
            }
            stopLoading();
          });
        });
  }
}
