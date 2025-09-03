import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/data/models/cart_item.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/routes/app_pages.dart';

class CartController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  var panierList = <CartItem>[].obs;

  RxList<Order> orders = RxList<Order>([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (orders.isEmpty) {
      loadOrdersData();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si la localisation est activée
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Les services de localisation sont désactivés
      return Future.error('Les services de localisation sont désactivés.');
    }

    // Vérifie la permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission de localisation refusée');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les permissions sont refusées pour toujours, ouvrir paramètres
      return Future.error(
          'Permission de localisation refusée en permanence. Activez-la dans les paramètres.');
    }

    // Si tout est OK → récupère la position
    return await Geolocator.getCurrentPosition();
  }

  void storeCommand() async {
    Position? position = await determinePosition();
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
    await produitProvider.storeCommand(data: data).then((response) {
      panierList.clear();
      if (response != null) {
        Get.find<SocketController>()
            .listenToMyOrderTraitement(orderId: response['order_id']);

        Get.toNamed(AppPages.CLIENT_FEED_BACK_ORDER);
      }
    });
  }

  void loadOrdersData() async {
    orders.value = await produitProvider.getOrdersCommand() ?? [];
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
