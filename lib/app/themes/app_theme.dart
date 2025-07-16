import 'package:flutter/material.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    hintColor: Colors.green,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.background),
    cardTheme: CardTheme(color: AppColors.secondary),
    canvasColor: AppColors.secondary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    hintColor: Colors.orange,
    scaffoldBackgroundColor: AppColors.background,
    cardTheme: CardTheme(color: AppColors.secondary),
    canvasColor: AppColors.secondary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),
  );
}
