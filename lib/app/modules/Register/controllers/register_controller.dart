import 'package:e_pharma/app/utils/form_helper.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // form controllers
  final phoneController = FormHelper.getController();
  final passwordController = FormHelper.getController();
  final confirmPasswordController = FormHelper.getController();
  // Reactive variable to handle password visibility
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  RxString contryCode = '+225'.obs;
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
}
