// services/localization_service.dart
import 'package:e_pharma/app/utils/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends GetxService {
  static LocalizationService get to => Get.find();
  // Supported languages
  final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('fr', 'FR'),
  ];

  Future<LocalizationService> init() async {
    await GetStorage.init();
    return this;
  }

  Locale getCurrentLocale() {
    String? languageCode = StorageHelper.get('languageCode');
    String? countryCode = StorageHelper.get('countryCode');

    if (languageCode == null || countryCode == null) {
      return _getDeviceLocale();
    }
    return Locale(languageCode, countryCode);
  }

  Locale _getDeviceLocale() {
    final deviceLocale = Get.deviceLocale;
    if (deviceLocale != null && supportedLocales.contains(deviceLocale)) {
      return deviceLocale;
    }
    return const Locale('en', 'US');
  }

  void updateLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;

    Get.updateLocale(locale);
    StorageHelper.set('languageCode', locale.languageCode);
    StorageHelper.set('countryCode', locale.countryCode);
  }
}
