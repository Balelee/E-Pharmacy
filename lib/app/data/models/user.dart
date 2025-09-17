import 'package:pharmix/app/data/models/pharmacy.dart';

class User {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? phone;
  String? birthdate;
  String? birthplace;
  String? email;
  String? type;
  String? password;
  Pharmacy? pharmacie;
  String? status;
  String? statusLabel;

  User(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.phone,
      this.birthdate,
      this.birthplace,
      this.email,
      this.type,
      this.pharmacie,
      this.password,
      this.status,
      this.statusLabel});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['userName'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      phone: json['phone'],
      birthdate: json['birthDate'],
      birthplace: json['birthPlace'],
      email: json['email'],
      type: json['type'],
      password: json['password'],
      pharmacie: json['pharmacie'] != null
          ? Pharmacy.fromJson(json['pharmacie'])
          : null,
      status: json['status'],
      statusLabel: json['status_label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': username,
      'firstName': firstname,
      'lastName': lastname,
      'phone': phone,
      'birthDate': birthdate,
      'birthPlace': birthplace,
      'email': email,
      'type': type,
      'password': password,
      'pharmacie': pharmacie?.toJson(),
    };
  }

  User copyWith(
      {int? id,
      String? username,
      String? firstname,
      String? lastname,
      String? phone,
      String? birthdate,
      String? birthplace,
      String? email,
      String? type,
      String? name}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        birthdate: birthdate ?? this.birthdate,
        birthplace: birthplace ?? this.birthplace,
        email: email ?? this.email,
        type: type ?? this.type,
        password: password ?? this.password,
        pharmacie: pharmacie ?? this.pharmacie);
  }

  String get fullName => "${firstname ?? ''} ${lastname ?? ''}".trim();
  String? get role => type;
  String? get pharmacyName => pharmacie?.name;
  bool get isActif => status == "actif" ? true : false;
}
