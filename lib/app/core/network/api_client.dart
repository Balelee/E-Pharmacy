import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmix/app/config/env.dart';
import 'api_exception.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiClient {
  static String baseUrl = Env.apiUrl;

  /// 🔹 Fonction pour obtenir la marque et le modèle de l'appareil
  static Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String brand = 'Inconnu';
    String model = 'Inconnu';

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      brand = info.brand ?? 'Inconnu';
      model = info.model ?? 'Inconnu';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      brand = 'Apple';
      model = info.utsname.machine ?? 'Inconnu';
    }

    return {'brand': brand, 'model': model};
  }

  // Headers with or without authentication
  static Future<Map<String, String>> headers(
      {String? token, bool auth = false}) async {
    String? lang = Get.locale?.languageCode;
    final device = await getDeviceInfo();
    final brand = device['brand'] ?? 'Inconnu';
    final model = device['model'] ?? 'Inconnu';
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'accept-language': lang ?? 'fr',
      // 👉 User-Agent maintenant dynamique
      'User-Agent': '$brand $model (Flutter; ${Platform.operatingSystem})',
      // Et on envoie aussi séparément si tu veux les lire côté backend
      'Device-Brand': brand,
      'Device-Model': model,
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
