import 'package:e_pharma/app/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: Env.debugMode,
      title: Env.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
