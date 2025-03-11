import 'package:e_pharma/app/data/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var panierList = <Product>[].obs;
  var quantity = 1.obs;

  void increment() => quantity++;
  void decrement() {
    if (quantity > 1) quantity--;
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
