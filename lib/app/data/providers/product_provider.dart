import 'dart:convert';

import 'package:e_pharma/app/cummon/controllers/base_controller.dart';
import 'package:e_pharma/app/data/providers/api_provider.dart';
import 'package:e_pharma/app/utils/enums/api_routes.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';
import 'package:flutter/services.dart';

import '../models/product.dart';

class ProductProvider with BaseController {
  // Future<List<Product>> fetchProduits() async {
  //   try {
  //     // Charger le fichier JSON depuis les assets
  //     final String response =
  //         await rootBundle.loadString('assets/products.json');
  //     final List<dynamic> data = json.decode(response);
  //     return data.map((json) => Product.fromJson(json)).toList();
  //   } catch (e) {
  //     throw Exception('Erreur lors du chargement des produits: $e');
  //   }
  // }

  Future<dynamic> fetchProduits({required int pageKey}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.products.format({'pageKey': pageKey.toString()}),
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

  Future<dynamic> storeCommand({required Map<String, dynamic> data}) async {
    try {
      print("Arrive ici");
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.ordersProduct.path,
        data: data,
      ).catchError(handleError);
      print("Atteint ici");
      print(response);
      hideLoading();
      if (response != null && response['data'] != null) {
        return response;
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }
}
