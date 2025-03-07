import 'package:get/get.dart';

import '../../../data/models/product.dart';
import '../../../data/providers/product_provider.dart';

class ProductController extends GetxController {
  var produits = <Product>[].obs;
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
}
