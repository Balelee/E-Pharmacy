class AuthMessage {
  final String? message;
  final String? phone;
  AuthMessage({
    required this.message,
    required this.phone,
  });

  factory AuthMessage.fromJson(Map<String, dynamic> json) {
    return AuthMessage(
      message: json['message'],
      phone: json['phone'],
    );
  }
}
