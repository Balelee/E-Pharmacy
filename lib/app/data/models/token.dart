import 'package:get_storage/get_storage.dart';

class Token {
  static final _storage = GetStorage();

  static void save(String token) {
    _storage.write('auth_token', token);
  }

  static String get() {
    return _storage.read('auth_token') ?? '';
  }

  static void clear() {
    _storage.remove('auth_token');
  }
}
