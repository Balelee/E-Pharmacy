

import 'package:pharmix/app/data/models/pagination_links.dart';
import 'package:pharmix/app/data/models/pagination_meta.dart';
import 'package:pharmix/app/data/models/product.dart';

class PaginatedProducts {
  final List<Product> data;
  final PaginationLinks links;
  final PaginationMeta meta;

  PaginatedProducts({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PaginatedProducts.fromJson(Map<String, dynamic> json) {
    return PaginatedProducts(
      data: List<Product>.from(
          json['data'].map((item) => Product.fromJson(item))),
      links: PaginationLinks.fromJson(json['links']),
      meta: PaginationMeta.fromJson(json['meta']),
    );
  }
}
