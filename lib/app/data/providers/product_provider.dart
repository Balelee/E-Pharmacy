import 'dart:convert';

import 'package:e_pharma/app/cummon/controllers/base_controller.dart';
import 'package:e_pharma/app/data/models/order.dart';
import 'package:e_pharma/app/data/models/product_filter.dart';
import 'package:e_pharma/app/data/providers/api_provider.dart';
import 'package:e_pharma/app/utils/enums/api_routes.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';

class ProductProvider with BaseController {
  Future<dynamic> fetchProduits(
      {required int pageKey, String? query, String? filter}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.products.format(
            {'pageKey': pageKey.toString(), 'query': query, 'filter': filter}),
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        return response;
      }
      return null;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<Order>?> storeCommand(
      {required Map<String, dynamic> data}) async {
    try {
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.ordersProduct.path,
        data: data,
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<ProductFilter>> loadFilterProductsData() async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.filterProduct.path,
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<ProductFilter> filterProduct =
            data.map((json) => ProductFilter.fromJson(json)).toList();
        return filterProduct;
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }
}
