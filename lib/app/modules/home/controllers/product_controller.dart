import 'package:e_pharma/app/data/models/cart_item.dart';
import 'package:e_pharma/app/data/models/paginated_transaction.dart';
import 'package:e_pharma/app/data/models/product_filter.dart';
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
  RxList<ProductFilter> productFilters = RxList([]);
  Rxn<ProductFilter> selectedCategory = Rxn();

  final ProductProvider produitProvider = ProductProvider();
  RxnString query = RxnString(null);
  final RxBool _isDisposed = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    if (productFilters.isEmpty) {
      loadProductFilters();
    }
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey: pageKey);
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (productFilters.isEmpty) {
      loadProductFilters();
    }
  }

  @override
  void onClose() {
    super.onClose();
    _isDisposed.value = true;
    pagingController.dispose();
  }

  void loadProductFilters() async {
    productFilters.value = await produitProvider.loadFilterProductsData();
    productFilters.insert(0, ProductFilter(filter: '', label: "All"));
    selectedCategory.value = productFilters.first;
  }

  void updateCategory(ProductFilter category) {
    selectedCategory.value = category;
    if (!_isDisposed.value) {
      pagingController.refresh();
    }
  }

  void fetchResearchData({required String? label}) async {
    query.value = label;
    if (!_isDisposed.value) {
      pagingController.refresh();
    }
  }

  // Fonction pour charger les produits
  Future<void> _fetchPage({required int pageKey}) async {
    if (_isDisposed.value) return;
    try {
      final response = await produitProvider.fetchProduits(
          pageKey: pageKey,
          query: query.value,
          filter: selectedCategory.value?.filter.toString());
      if (_isDisposed.value) return;
      if (response['data'].isEmpty) {
        pagingController.appendLastPage([]);
      } else {
        final products = PaginatedProducts.fromJson(response);
        _pageSize.value = products.meta.total;
        final isLastPage = products.meta.currentPage == products.meta.lastPage;
        if (isLastPage) {
          pagingController.appendLastPage(products.data);
        } else {
          pagingController.appendPage(products.data, pageKey + 1);
        }
      }
    } catch (error) {
      if (!_isDisposed.value) {
        pagingController.error = error;
      }
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
