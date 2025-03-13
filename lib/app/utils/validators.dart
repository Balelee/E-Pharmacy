import 'package:e_pharma/app/utils/constants/app_constant.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validators {
  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(
      {String? value, required TextEditingController passwordController}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (value != passwordController.text.toString()) {
      return LocaleKeys.identique_password_error.tr;
    }
    return null;
  }

  // Phone number validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
    //   return 'Enter a valid phone number';
    // }
    return null;
  }

  // OTP validator
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP code is required';
    }
    if (value.length != AppConstant.otpLength) {
      return 'OTP must be ${AppConstant.otpLength} digits';
    }
    return null;
  }
}
