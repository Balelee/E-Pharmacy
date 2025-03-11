import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

class ProductProvider {
  Future<List<Product>> fetchProduits() async {
    try {
      // Charger le fichier JSON depuis les assets
      final String response =
          await rootBundle.loadString('assets/products.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des produits: $e');
    }
  }
}
