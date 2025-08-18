import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmix/app/config/env.dart';
import 'api_exception.dart';

class ApiClient {
  static String baseUrl = Env.apiUrl;

  // Headers with or without authentication
  static Map<String, String> headers({String? token, bool auth = false}) {
    String? lang = Get.locale?.languageCode;
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'accept-language': lang ?? 'fr',
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
      default:
        throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
