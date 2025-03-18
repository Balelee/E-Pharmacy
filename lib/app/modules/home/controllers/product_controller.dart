import 'package:e_pharma/app/data/models/cart_item.dart';
import 'package:e_pharma/app/data/models/paginated_transaction.dart';
import 'package:e_pharma/app/data/models/user.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/product.dart';
import '../../../data/providers/product_provider.dart';

class ProductController extends GetxController {
  var produits = <Product>[].obs;
  var panierList = <CartItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  late PagingController<int, Product> pagingController;
  final RxInt _pageSize = 10.obs;
  RxString deliveryAdress = RxString("Abidjan, cocody");
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

  // Fonction pour charger les produits
  Future<void> _fetchPage({required int pageKey}) async {
    try {
      final response = await produitProvider.fetchProduits(pageKey: pageKey);
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
      pagingController.error = error;
    }
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
  double get totalPrice => totalCommande + fraisLivraison;

  void payeForProducts() async {
    var data = {
      "user_id": 2,
      "total_price": totalPrice,
      "delivery_adress": deliveryAdress.value,
      "items": panierList
          .map((item) => {
                "product_id": item.product.id,
                "quantity": item.quantity,
                "price": item.product.price,
              })
          .toList(),
    };
    var storedCommand =
        await produitProvider.storeCommand(data: data).then((data) {
      print("produitProvider");
      print(data);
    });
    // panierList.forEach((item) {
    //   print(item.quantity);
    //   print(item.product.toJson());
    // });
  }
}
