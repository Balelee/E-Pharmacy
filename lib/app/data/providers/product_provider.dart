import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/auxiliaire_request.dart';
import 'package:pharmix/app/data/models/product.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/data/models/request_pharmacy.dart';
import 'package:pharmix/app/data/models/searchproduct.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/data/enums/request_status_enum.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class ProductProvider with BaseController {
  Future<List<Product>> fetchProduits(
      {required int pageKey, String? query, String? filter}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.products.format(
            {'pageKey': pageKey.toString(), 'query': query, 'filter': filter}),
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        List<dynamic> datas = response['data'];
        return datas.map((produit) => Product.fromJson(produit)).toList();
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }

  Future<dynamic> fetchClientRequests(
      {required int pageKey, String? query, String? filter}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.getUserRequests.format(
            {'pageKey': pageKey.toString(), 'query': query, 'filter': filter}),
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        print(response);
        final List<dynamic> data = response['data'];
        return data.map((json) => Request.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> newRequest(
      {required Map<String, dynamic> data}) async {
    try {
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.newUserRequests.path,
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

  Future<List<AuxiliaireRequest>?> getRequestPharmacies(
      {RequestPharmacyStatusEnum requestPharmacyStatus =
          RequestPharmacyStatusEnum.enattente,
      bool isLoading = false}) async {
    try {
      isLoading ? showLoading() : null;
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.requestspharmacies
            .format({'status': requestPharmacyStatus.value}),
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => AuxiliaireRequest.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<RequestPharmacy>?> getRequestsTRPharmacies(
      {RequestPharmacyStatusEnum requestPharmacyStatus =
          RequestPharmacyStatusEnum.traite}) async {
    try {
      showLoading();
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.requestsTRpharmacies
            .format({'status': requestPharmacyStatus.value}),
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => RequestPharmacy.fromJson(json)).toList();
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
}
