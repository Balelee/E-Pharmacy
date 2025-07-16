
import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/models/product_filter.dart';
import 'package:pharmix/app/data/models/searchproduct.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

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

  Future<List<Order>?> getOrdersCommand() async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.ordersProduct.path,
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
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

 Future<List<Searchproduct>> searchProductByName(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.searchProduct.format({
          'query': query,
          'page': page,
          'limit': limit,
        }),
      ).catchError(handleError);

      if (response != null && response is Map && response['data'] is List) {
        List<Searchproduct> searchproduct = (response['data'] as List)
            .map((item) => Searchproduct.fromJson(item))
            .cast<Searchproduct>()
            .toList();
        return searchproduct;
      }

      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur de recherche: $e");
      return [];
    }
  }

}
