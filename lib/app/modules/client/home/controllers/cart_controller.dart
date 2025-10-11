import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/data/models/cart_item.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';

class CartController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  var panierList = <CartItem>[].obs;
  LocationHelper locationHelper = LocationHelper();

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

  void newRequest() async {
    Position? position = await locationHelper.allowPermission();
    double lat = position?.latitude ?? 0;
    double lng = position?.longitude ?? 0;
    var data = {
      "total_price": totalPrice,
      "lat": lat,
      "lng": lng,
      "items": panierList
          .map((item) => {
                "product_id": item.product.id,
                "quantity": item.quantity,
                "price": item.product.price,
              })
          .toList(),
    };
    await produitProvider.newRequest(data: data).then((response) {
      panierList.clear();
      if (response != null) {
        Get.find<SocketController>()
            .listenToMyRequestTraitement(requestId: response['request_id']);

        Get.toNamed(AppPages.CLIENT_FEED_BACK_ORDER);
      }
    });
  }

  void incrementQuantity(int productId) {
    int index = panierList.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      panierList[index].quantity++;
      panierList.refresh();
    }
  }

  void decrementQuantity(int productId) {
    int index = panierList.indexWhere((item) => item.product.id == productId);
    if (index != -1 && panierList[index].quantity > 1) {
      panierList[index].quantity--;
      panierList.refresh();
    }
  }

  void removeFromCart(int productId) {
    var cartItem =
        panierList.firstWhereOrNull((item) => item.product.id == productId);
    if (cartItem != null) {
      panierList.remove(cartItem);
      panierList.refresh();
    }
  }

  double get totalCommande => panierList.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));

  double fraisLivraison = 2050;
  double get totalPrice => totalCommande + fraisLivraison;
}
