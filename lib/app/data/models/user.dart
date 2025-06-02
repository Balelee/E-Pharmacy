

class User {
  final int id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? birthdate;
  final String? birthplace;
  final String? email;
  final String? address;
  final String? joinedAt;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.birthdate,
    required this.birthplace,
    required this.email,
    required this.address,
    required this.joinedAt,
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
      address: json['adress'] ?? "",
      joinedAt: json['joinedAt'] ?? "",
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
      'adress': address,
      'joinedAt': joinedAt,
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
    String? address,
    String? joinedAt,
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
      address: address ?? this.address,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
