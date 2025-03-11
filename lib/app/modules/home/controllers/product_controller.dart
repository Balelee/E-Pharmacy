import 'package:e_pharma/app/data/models/cart_item.dart';
import 'package:get/get.dart';

import '../../../data/models/product.dart';
import '../../../data/providers/product_provider.dart';

class ProductController extends GetxController {
  var produits = <Product>[].obs;
  var panierList = <CartItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // product category filter

  var selectedCategory = 'All'.obs;
  var categories = [
    "All",
    "Anti douleur",
    "Antibiotiques",
    "Anti-inflammatoires",
    "Psychotropes",
    "Antiviraux",
    "Antidiabétiques"
  ].obs;

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  List<Product> get filteredProducts {
    if (selectedCategory.value == "All") return produits;
    return produits.where((p) => p.category == selectedCategory.value).toList();
  }

  final ProductProvider produitProvider = ProductProvider();
  @override
  void onInit() {
    super.onInit();
    loadProduits();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Fonction pour charger les produits
  Future<void> loadProduits() async {
    try {
      isLoading(true);
      produits.value = await produitProvider.fetchProduits();
      // panierList.addAll([, produits[1], produits[2]]);
    } catch (e) {
      errorMessage.value = 'Erreur: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addToCart(Product product) {
    int index = panierList.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      panierList[index].quantity++;
    } else {
      panierList.add(CartItem(product: product));
    }
    panierList.refresh();
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
  double get totalGeneral => totalCommande + fraisLivraison;
}
