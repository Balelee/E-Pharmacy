import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColorLight: Colors.blue,
    hintColor: Colors.green,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),
   
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    hintColor: Colors.orange,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),

  );
}
