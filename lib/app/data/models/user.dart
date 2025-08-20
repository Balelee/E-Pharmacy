import 'package:pharmix/app/data/models/pharmacy.dart';

class User {
  final int? id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? birthdate;
  final String? birthplace;
  final String? email;
  final String? type;
  final String? password;
  final Pharmacy? pharmacie;

  User({
    this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.birthdate,
    required this.birthplace,
    required this.email,
    this.type,
    this.pharmacie,
    required this.password,
  });

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
      'userType': type,
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
}
