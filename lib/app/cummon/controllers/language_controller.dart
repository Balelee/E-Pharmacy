import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/utils/services/localization_service.dart';

class LanguageController extends GetxController {
  final LocalizationService localizationService = LocalizationService.to;

  void changeLanguage(Locale locale) {
    localizationService.updateLocale(locale);
    Get.updateLocale(locale);
  }
}
