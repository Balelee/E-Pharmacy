import 'package:e_pharma/app/data/models/cart_item.dart';
import 'package:e_pharma/app/data/models/paginated_transaction.dart';
import 'package:e_pharma/app/data/models/user.dart';
import 'package:e_pharma/app/modules/home/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/product.dart';
import '../../../data/providers/product_provider.dart';

class ProductController extends GetxController {
  CartController cartController = Get.find<CartController>();
  var produits = <Product>[].obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  late PagingController<int, Product> pagingController;
  final RxInt _pageSize = 10.obs;

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
  RxnString query = RxnString(null);
  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey: pageKey);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchResearchData({required String? label}) async {
    query.value = label;
    pagingController.refresh();
  }

  // Fonction pour charger les produits
  Future<void> _fetchPage({required int pageKey}) async {
    try {
      final response = await produitProvider.fetchProduits(
          pageKey: pageKey, query: query.value);
      if (response['data'].isEmpty) {
        pagingController.appendLastPage([]);
      } else {
        final products = PaginatedProducts.fromJson(response);
        _pageSize.value = products.meta.total;
        final isLastPage = products.meta.currentPage == products.meta.lastPage;
        if (isLastPage) {
          print("On est ici");
          print(products.data);
          pagingController.appendLastPage(products.data);
        } else {
          pagingController.appendPage(products.data, pageKey + 1);
        }
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void addToCart(Product product) {
    int index = cartController.panierList
        .indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartController.panierList[index].quantity++;
    } else {
      cartController.panierList.add(CartItem(product: product));
    }
    cartController.panierList.refresh();
  }


 
}
