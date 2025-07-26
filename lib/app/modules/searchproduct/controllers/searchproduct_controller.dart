import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/searchproduct.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/modules/home/controllers/cart_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class SearchproductController extends GetxController {
  final searchController = TextEditingController();
  CartController cartController = Get.find<CartController>();
  RxString searchText = ''.obs;
  RxList<Searchproduct> products = <Searchproduct>[].obs;
  final productProvider = ProductProvider();
  RxInt favoriteCount = 0.obs;
  RxBool isNameAsc = true.obs;
  Rx<Color> iconColor = AppColors.textSecondary.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 20;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;
  final RxBool showToast = true.obs;
  final scrollController = ScrollController();

  Timer? debounce;

  void onSearchChanged(String query) {
    searchText.value = query;
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      searchProduct(query.trim());
    });
  }

  void searchProduct(String query, {int page = 1}) async {
    if (query.isEmpty) {
      products.clear();
      DialogHelper.hideLoading();
      return;
    }

    DialogHelper.showLoading(
      message: LocaleKeys.patienter.tr,
      noBkgColor: true,
      colorProgress: Colors.green,
      messageStyle: const TextStyle(fontWeight: FontWeight.bold),
    );

    try {
      final result = await productProvider.searchProductByName(
        query,
        page: page,
        limit: pageSize,
      );
      products.value = result;
      currentPage.value = page;
    } catch (e) {
      products.clear();
    } finally {
      DialogHelper.hideLoading();
    }
  }

  void sortByName() {
    isNameAsc.value = !isNameAsc.value;
    products.sort((a, b) => isNameAsc.value
        ? a.productName.compareTo(b.productName)
        : b.productName.compareTo(a.productName));
    iconColor.value = iconColor.value == AppColors.textSecondary
        ? Colors.green
        : AppColors.textSecondary;
    products.refresh();
  }

  void loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value || searchText.value.isEmpty) {
      return;
    }
    isLoadingMore.value = true;
    try {
      final nextPage = currentPage.value + 1;
      final result = await productProvider.searchProductByName(
        searchText.value,
        page: nextPage,
        limit: pageSize,
      );

      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        products.addAll(result);
        currentPage.value = nextPage;
      }
    } catch (e) {
      hasMore.value = false;
    } finally {
      isLoadingMore.value = false;
      products.refresh();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreProducts();
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    debounce?.cancel();
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
