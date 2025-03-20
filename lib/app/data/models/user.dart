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

  static void saveUser(User user) {
    String userJson = jsonEncode(user.toJson());
    StorageHelper.set('user', userJson);
  }

  static User? getUser() {
    String? userJson = StorageHelper.get('user');
    if (userJson != null && userJson.isNotEmpty) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static void clearUser() {
    StorageHelper.delete('user');
  }
}
