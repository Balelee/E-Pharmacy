import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmix/app/config/env.dart';
import 'package:pharmix/app/data/models/device_info.dart';
import 'api_exception.dart';

class ApiClient {
  static String baseUrl = Env.apiUrl;


  // Headers with or without authentication
  static Map<String, String> headers(
      {String? token, bool auth = false})  {
    String? lang = Get.locale?.languageCode;
    DeviceInfo deviceInfo = DeviceInfo.getDeviceInfo();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'accept-language': lang ?? 'fr',
      'User-Agent': '${deviceInfo.brand} ${deviceInfo.model}',
    };
    if (auth) {
      header['Authorization'] = 'Bearer $token';
    }
    return header;
  }

  // Process API response
  static dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(utf8.decode(response.bodyBytes));
      case 500:
        throw ApiException('Erreur de serveur');
      default:
        throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
