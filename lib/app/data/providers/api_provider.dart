import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/token.dart';

class ApiProvider {
  static const int timeOutDuration = 200;

  static Future<dynamic> get(
      {bool auth = true, required String apiURL, bool isPhone = false}) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .get(Uri.parse(ApiClient.baseUrl + apiURL),
              headers:  ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));
      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> post({
    required bool auth,
    required Map<String, dynamic> data,
    required String apiURL,
    bool isPhone = false,
  }) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .post(Uri.parse(ApiClient.baseUrl + apiURL),
              body: jsonEncode(data),
              headers: ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));

      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> put({
    required bool auth,
    required String apiURL,
    required Map<String, dynamic> data,
    bool isPhone = false,
  }) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .put(
            Uri.parse(ApiClient.baseUrl + apiURL),
            headers: ApiClient.headers(auth: auth, token: token),
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: timeOutDuration));
      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }


  static Future<dynamic> delete({
    bool auth = false,
    required String apiURL,
    bool isPhone = false,
  }) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .delete(Uri.parse(ApiClient.baseUrl + apiURL),
              headers: ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));
      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }
}
