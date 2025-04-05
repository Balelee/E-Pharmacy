import 'dart:convert';

import 'package:e_pharma/app/utils/helpers/storage_helper.dart';

class User {
  final int id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? birthdate;
  final String? birthplace;
  final String? email;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.birthdate,
    required this.birthplace,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      birthdate: json['birthdate'],
      birthplace: json['birthplace'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'birthdate': birthdate,
      'birthplace': birthplace,
      'email': email,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? firstname,
    String? lastname,
    String? phone,
    String? birthdate,
    String? birthplace,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      birthdate: birthdate ?? this.birthdate,
      birthplace: birthplace ?? this.birthplace,
      email: email ?? this.email,
    );
  }
}
