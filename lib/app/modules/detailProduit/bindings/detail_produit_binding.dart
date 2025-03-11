import 'package:get/get.dart';

import '../controllers/detail_produit_controller.dart';

class DetailProduitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProduitController>(
      () => DetailProduitController(),
    );
  }
}
