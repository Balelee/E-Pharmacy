
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/config/env.dart';
import 'package:pharmix/app/cummon/controllers/dependency_injection.dart';
import 'package:pharmix/app/themes/app_theme.dart';
import 'package:pharmix/app/utils/services/localization_service.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencieInjection.init();
  await initializeDateFormatting('fr', "");
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
      initialRoute: AppPages.INITIAL,
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
