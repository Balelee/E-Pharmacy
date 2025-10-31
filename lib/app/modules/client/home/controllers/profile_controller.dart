import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/form_helper.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class ProfileController extends GetxController {
  final AuthProvider authProvider = Get.put(AuthProvider());
  final UserController _userController = Get.find<UserController>();

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController placeOfBirthController = TextEditingController();
  late TextEditingController dateOfBirthController = TextEditingController();

  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();

  RxBool isLoding = RxBool(false);
  RxBool isEditting = RxBool(false);
  RxString loadingMessage = RxString("");

  String get userName => _userController.user?.fullName ?? "";
  String get userAdress => _userController.user?.type ?? 'No adress';
  String get userEmail => _userController.user?.email ?? 'No adress';

  String? get userAvatar => null;

  final RxString _editingField = RxString('');

  bool isEditing(String field) => _editingField.value == field;

  Future<void> startEditing(String field) async {
    _editingField.value = field;
  }

  @override
  void onInit() {
    super.onInit();
    _setInitialValues();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setIsEditting() {
    isEditting.value = true;
  }

  void cancelEditting() {
    isEditting.value = false;
    _setInitialValues();
  }

  void _setInitialValues() {
    lastNameController = FormHelper.getController(
        value: _userController.user?.lastname ?? '---------');
    firstNameController = FormHelper.getController(
        value: _userController.user?.firstname ?? '---------');
    emailController = FormHelper.getController(value: userEmail);
    phoneController = FormHelper.getController(
        value: _userController.user?.phone ?? '---------');
    placeOfBirthController = FormHelper.getController(
        value: _userController.user?.birthplace ?? '---------');
    dateOfBirthController = FormHelper.getController(
        value: _userController.user?.birthdate ?? '---------');
  }

  void setLoading({String loadMessage = "Loading..."}) {
    isLoding.value = true;
    loadingMessage.value = loadMessage;
  }

  void stopLoading() {
    isLoding.value = false;
    loadingMessage.value = "Loading...";
  }

  void updateData() async {
    var data = {
      "lastName": lastNameController.text,
      "firstName": firstNameController.text,
      "birthDate": dateOfBirthController.text,
      "birthPlace": placeOfBirthController.text,
      "email": emailController.text,
      "phone": phoneController.text
    };
    if (_userController.user?.id != null) {
      User? updatedUser = await authProvider.updateUser(
          data: data, userId: _userController.user!.id.toString());

      if (updatedUser != null) {
        await _userController.updateUser(updatedUser);
        cancelEditting();
        DialogHelper.showSuccessSnackbar(
            message: "Vos informations ont été mises à jour avec succès");
      } else {
        DialogHelper.showErrorSnackbar(
            message: "Impossible de mettre à jour vos informations");
      }
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
              if (Get.isRegistered<UserController>()) {
                Get.delete<UserController>();
              }
              SocketController socketController = Get.find<SocketController>();

              Get.find<UserRepository>().clearUser();
              var channels =
                  socketController.echo!.connector.channels.values.toList();
              for (var chanel in channels) {
                socketController.echo!.connector.leaveChannel(chanel.name);
              }
              socketController.echo!.connector.disconnect();
              socketController.echo = null;
              Get.offAllNamed(AppPages.LOGINCONTENT);
            }

            stopLoading();
          });
        });
  }
}
