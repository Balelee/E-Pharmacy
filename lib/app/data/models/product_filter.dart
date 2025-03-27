class ProductFilter {
  final String? label;
  final String? filter;

  ProductFilter({
    required this.label,
    required this.filter,
  });

  factory ProductFilter.fromJson(Map<String, dynamic> json) {
    return ProductFilter(
      label: json['label'],
      filter: json['value'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': filter,
    };
  }
}
