import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_theme.dart';

class GetTheme {
  static GetTheme get to => Get.find();

  ThemeData get theme {
    final mode = ThemeMode.system;
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      case ThemeMode.light:
        return AppTheme.lightTheme;
      case ThemeMode.system:
      final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
    }
  }

  Color get cardColor => theme.cardColor;
  Color? hintColor() => theme.hintColor;
  Color get primaryColor => theme.primaryColor;
  appBarTheme() => theme.appBarTheme;
  Color get scaffoldBackground => theme.scaffoldBackgroundColor;
  Color get textColor => theme.textTheme.bodyLarge!.color!;
  IconThemeData get iconTheme => theme.iconTheme;
  TextTheme? textTheme() => theme.textTheme;
}

