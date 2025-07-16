import 'package:get/get.dart';
import 'package:pharmix/app/data/models/cart_item.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';

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

  void storeCommand() async {
    var data = {
      "user_id": 2,
      "total_price": totalPrice,
      "items": panierList
          .map((item) => {
                "product_id": item.product.id,
                "quantity": item.quantity,
                "price": item.product.price,
              })
          .toList(),
    };
    orders.value = await produitProvider.storeCommand(data: data).then((data) {
      panierList.clear();

      return data ?? [];
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
