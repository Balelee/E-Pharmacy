import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/adminProvider/admin_provider.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class AdminhomeController extends GetxController {
  RxList<User> users = <User>[].obs;
  AdminProvider adminProvider = AdminProvider();
  final AuthProvider authProvider = Get.put(AuthProvider());
  PharmacyProvider pharmacieProvider = PharmacyProvider();

  RxList<Map<String, String>> roles = <Map<String, String>>[
    {'value': "pharmacien", 'label': "Pharmacien"},
    {'value': "client", 'label': "Client"},
    {'value': "admin", 'label': "Admin"},
  ].obs;
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers({bool isLoading = false}) async {
    final allUsers = await adminProvider.fetchUsers(isLoading: isLoading);

    users.assignAll(allUsers);
  }

  void assignRole(User user, String role) {
    user.type = role;
    users.refresh();
  }

  void assignPharmacy(User user, Pharmacy? pharmacy) {
    user.pharmacie = pharmacy;
    users.refresh();
  }

  void toggleUserStatus(User user, String status) {
    user.status = status;
    users.refresh();
  }

  void updateUserData(
      {required String userId, required Map<String, Object?> data}) async {
    bool isUpdated =
        await adminProvider.updateUserData(userId: userId, data: data);

    if (isUpdated) {
      print("isUpdated $isUpdated");
      if (Get.isOverlaysOpen == false) {
        DialogHelper.showSuccessSnackbar(
            message: "Donnée mis a jour", seconds: 2);
      }
      loadUsers();
    }
  }

  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");

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
              if (Get.isRegistered<UserController>()) {
                Get.delete<UserController>();
              }
              Get.find<UserRepository>().clearUser();
              Get.offAllNamed(AppPages.LOGINCONTENT);
            }

            stopLoading();
          });
        });
  }
}
