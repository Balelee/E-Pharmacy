

import 'package:pharmix/app/utils/helpers/storage_helper.dart';

class Token {
  static void savePhoneToken(String token) {
    StorageHelper.set('phone_token', token);
  }
  static void saveAuthToken(String token) {
     StorageHelper.set('auth_token', token);
  }
  static String getPhoneToken() {
    return StorageHelper.get('phone_token') ?? '';
  }
  static String getAuthToken() {
    return StorageHelper.get('auth_token') ?? '';
  }
  static void clearPhoneToken() {
    StorageHelper.delete('phone_token');
  }
  static void clearAuthToken() {
     StorageHelper.delete('auth_token');
  }
}
