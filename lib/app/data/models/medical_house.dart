class MedicalFacility {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String? latitude;
  final String? longitude;
  final String type; 

  MedicalFacility({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.latitude,
    this.longitude,
    required this.type,
  });

  factory MedicalFacility.fromJson(Map<String, dynamic> json) {
    return MedicalFacility(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
    };
  }

  bool get isClinique => type.toLowerCase() == 'clinique';
  bool get isLaboratoire => type.toLowerCase() == 'laboratoire';
}
