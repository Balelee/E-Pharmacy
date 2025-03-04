import 'package:e_pharma/app/utils/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final LocalizationService localizationService = LocalizationService.to;

  void changeLanguage(Locale locale) {
    localizationService.updateLocale(locale);
    Get.updateLocale(locale);
  }
}
