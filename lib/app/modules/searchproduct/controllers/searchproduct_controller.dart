import 'dart:async';

import 'package:e_pharma/app/data/models/searchproduct.dart';
import 'package:e_pharma/app/data/providers/product_provider.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchproductController extends GetxController {
  final searchController = TextEditingController();
  RxString searchText = ''.obs;
  RxList<Searchproduct> products = <Searchproduct>[].obs;
  final productProvider = ProductProvider();

  Timer? debounce;

  void onSearchChanged(String query) {
    searchText.value = query;
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      searchProduct(query.trim());
    });
  }

  void searchProduct(String query) async {
    if (query.isEmpty) {
      products.clear();
      DialogHelper.hideLoading();
      return;
    }
    DialogHelper.showLoading(
      message: "Patienter...",
      noBkgColor: true,
      colorProgress: AppColors.primary,
      messageStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
    try {
      final result = await productProvider.searchProductByName(query);
      products.value = result;
    } catch (e) {
      products.clear();
    } finally {
      DialogHelper.hideLoading();
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
