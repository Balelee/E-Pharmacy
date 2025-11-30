import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/data/models/cart_item.dart';
import 'package:pharmix/app/data/models/product_filter.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';

import '../../../../data/models/product.dart';
import '../../../../data/providers/product_provider.dart';

class ProductController extends GetxController {
  CartController cartController = Get.find<CartController>();
  SocketController socketController = Get.find<SocketController>();
  var produits = <Product>[].obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  // late PagingController<int, Product> pagingController;
  final RxInt _pageSize = 10.obs;

  // product category filter
  RxList<ProductFilter> productFilters = RxList([]);
  Rxn<ProductFilter> selectedCategory = Rxn();

  final ProductProvider produitProvider = ProductProvider();
  RxnString query = RxnString(null);
  final RxBool _isDisposed = RxBool(false);

  bool _isFetching = false;
  bool _hasLoadedFirstPage = false;
  late final PagingController<int, Product> pagingController;

  @override
  void onInit() {
    super.onInit();
    _initPagingController();
  }

  RxInt request_length = RxInt(0);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _isDisposed.value = true;
    pagingController.dispose();
  }

  void getOderLength() {
    request_length.value = 2;
  }

  void fetchResearchData({required String? label}) async {
    query.value = label;
    _performSearch();
  }

  Future<void> _performSearch() async {
    if (!_isDisposed.value) {
      _hasLoadedFirstPage = false;
      _isFetching = false;
      pagingController.cancel();
      pagingController.refresh();
    }
  }

  void _initPagingController() {
    pagingController = PagingController<int, Product>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchPage,
    );
  }

  Future<List<Product>> _fetchPage(int pageKey) async {
    if (_hasLoadedFirstPage && pageKey == 1) {
      return [];
    }

    if (_isFetching) return [];

    _isFetching = true;

    final newItems = await produitProvider.fetchProduits(
        pageKey: pageKey,
        query: query.value,
        filter: selectedCategory.value?.filter.toString());

    _isFetching = false;
    _hasLoadedFirstPage = true;
    return newItems;
  }

  void updateCategory(ProductFilter category) {
    selectedCategory.value = category;
    if (!_isDisposed.value) {
      pagingController.refresh();
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
