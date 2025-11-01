class TypeModel {
  final String? label;
  final String? filter;
  final int? count;

  TypeModel({
    required this.label,
    required this.filter,
    required this.count,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      label: json['label'],
      filter: json['filter'],
      count: json['count'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'filter': filter,
      'count': count,
    };
  }
}
