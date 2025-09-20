import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/auxiliaire_order.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/data/models/searchproduct.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/enums/order_status_enum.dart';
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

  Future<Map<String, dynamic>?> storeCommand(
      {required Map<String, dynamic> data}) async {
    try {
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.ordersProductbyUser.path,
        data: data,
      ).catchError(handleError);
      hideLoading();
      if (response != null) {
        return response as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<AuxiliaireOrder>?> getOrdersPharmacies(
      {OrderPharmacyStatusEnum orderPharmacyStatus =
          OrderPharmacyStatusEnum.enattente,
      bool isLoading = false}) async {
    try {
      isLoading ? showLoading() : null;
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.orderspharmacies
            .format({'status': orderPharmacyStatus.value}),
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => AuxiliaireOrder.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<OrderPharmacy>?> getOrdersTRPharmacies(
      {OrderPharmacyStatusEnum orderPharmacyStatus =
          OrderPharmacyStatusEnum.traite}) async {
    try {
      showLoading();
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.ordersTRpharmacies
            .format({'status': orderPharmacyStatus.value}),
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => OrderPharmacy.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
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

  Future<Order?> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    try {
      final response = await ApiProvider.put(
        auth: true,
        apiURL: ApiRoutes.orderStatus.format({'orderId': orderId}),
        data: {'status': status},
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        return Order.fromJson(response['data']);
      }
      DialogHelper.showErrorSnackbar(message: "Échec de la mise à jour.");
      return null;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur: $e");
      return null;
    }
  }

  Future<List<AuxiliaireOrder>> getOrdersByStatus(String status) async {
    try {
      final String url = status == "traite"
          ? ApiRoutes.ordersValide.path
          : ApiRoutes.ordersAnnule.path;
      final response = await ApiProvider.get(
        auth: true,
        apiURL: url,
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => AuxiliaireOrder.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }
}
