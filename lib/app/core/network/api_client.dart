import 'dart:convert';
import 'package:e_pharma/app/config/env.dart';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

class ApiClient {
  static String baseUrl = Env.apiUrl;

  // Headers with or without authentication
  static Map<String, String> headers({String? token, bool auth = false}) {
    return auth
        ? {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }
        : {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          };
  }

  // Process API response
  static dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(utf8.decode(response.bodyBytes));
      default:
        throw ApiException(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
}
