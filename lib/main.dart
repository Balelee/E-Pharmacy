import 'package:e_pharma/app/config/env.dart';
import 'package:e_pharma/app/cummon/controllers/dependency_injection.dart';
import 'package:e_pharma/app/themes/app_theme.dart';
import 'package:e_pharma/app/utils/services/localization_service.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencieInjection.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: Env.debugMode,
      title: Env.appName,
      initialRoute: AppPages.BASE,
      getPages: AppPages.routes,
      locale: LocalizationService.to.getCurrentLocale(),
      translationsKeys: AppTranslation.translations,
      fallbackLocale: Locale('fr', 'FR'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    ),
  );
}
