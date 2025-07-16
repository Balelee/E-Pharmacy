import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final AuthProvider authProvider = Get.put(AuthProvider());
  final UserController _userController = UserController.to;

  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");

  String get userName =>
      _userController.user?.username ??
      '${_userController.user?.firstname ?? ''} ${_userController.user?.lastname ?? ''}'
          .trim();

  String get userEmail => _userController.user?.email ?? 'No email';
  String get userPhone => _userController.user?.phone ?? 'No phone';
  String get userAdress => _userController.user?.address ?? 'No adress';
  String get userbirthday => _userController.user?.birthdate ?? 'No birthday';
  String get userbirtplace =>
      _userController.user?.birthplace ?? 'No birthplace';
  String? get userAvatar => null;

  final RxString _editingField = RxString('');

  bool isEditing(String field) => _editingField.value == field;

  Future<void> startEditing(String field) async {
    _editingField.value = field;
  }

  Future<void> cancelEditing() async {
    _editingField.value = '';
  }

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

  Future<void> updateField({
    required String field,
    required String value,
  }) async {
    try {
      final currentUser = _userController.user;
      if (currentUser == null) return;

      final updatedUser = currentUser.copyWith(
        firstname: field == 'firstname' ? value : currentUser.firstname,
        lastname: field == 'lastname' ? value : currentUser.lastname,
        email: field == 'email' ? value : currentUser.email,
        phone: field == 'phone' ? value : currentUser.phone,
        address: field == 'address' ? value : currentUser.address,
      );

      await _userController.updateUser(updatedUser).then((value) {
        _editingField.value = '';
        Get.snackbar('Success', '$field updated successfully');
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update $field: ${e.toString()}');
    }
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
