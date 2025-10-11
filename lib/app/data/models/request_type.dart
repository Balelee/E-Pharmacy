class RequestTypeModel {
  final String? label;
  final String? filter;
  final int? count;

  RequestTypeModel({
    required this.label,
    required this.filter,
    required this.count,
  });

  factory RequestTypeModel.fromJson(Map<String, dynamic> json) {
    return RequestTypeModel(
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
