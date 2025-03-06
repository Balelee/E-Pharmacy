import 'package:e_pharma/app/config/env.dart';
import 'package:e_pharma/app/cummon/controllers/language_controller.dart';
import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/themes/app_theme.dart';
import 'package:e_pharma/app/utils/services/localization_service.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  Get.put(NavigationController());
  Get.put(LocalizationService());
  Get.put(LanguageController());
  await dotenv.load(fileName: Env.isLocal ? Env.developement : Env.production);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: Env.debugMode,
      title: Env.appName,
      initialRoute: AppPages.HOME,
      getPages: AppPages.routes,
      locale: LocalizationService.to.getCurrentLocale(),
      translationsKeys: AppTranslation.translations,
      fallbackLocale: Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    ),
  );
}
