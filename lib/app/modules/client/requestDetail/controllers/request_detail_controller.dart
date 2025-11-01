import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request.dart';

class RequestDetailController extends GetxController {
  Rxn<Request> request = Rxn();
  RxString deliveryAdress = RxString("Abidjan, cocody");
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

  double get totalCommande =>
      request.value?.requestDetails.fold(
          0,
          (sum, item) =>
              sum! +
              (int.parse(item.priceUnitaire.toString()) *
                  int.parse(item.quantity.toString()))) ??
      0.0;

  double fraisLivraison = 2050;
  double get totalPrice => totalCommande + fraisLivraison;
}
