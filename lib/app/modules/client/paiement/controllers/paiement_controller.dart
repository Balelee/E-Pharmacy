import 'package:get/get.dart';

class PaiementController extends GetxController {

   RxString selectedMethod = 'OrangeMoney'.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  String get codeUSSD {
    switch (selectedMethod.value) {
      case 'OrangeMoney':
        return '*144*4*6*100#';
      case 'MoovMoney':
        return '*555*4*6*100#';
      default:
        return '';
    }
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

  
}
