import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiUrl => dotenv.env['API_URL'] ?? 'https://default.com';
  static String get appName => dotenv.env['APP_NAME'] ?? 'My App';
  static bool get debugMode => dotenv.env['DEBUG_MODE'] == 'true';

  static String get developement => ".env";
  static String get production => ".env.production";
  static bool get isLocal => true;
}
