import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/generated/locales.g.dart';

class Validators {
  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.msg_require_email.tr;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return LocaleKeys.valid_email_msg.tr;
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.msg_require_password.tr;
    }
    if (value.length < 8) {
      return LocaleKeys.min_password_msg.tr;
    }
    return null;
  }

  static String? validateConfirmPassword(
      {String? value, required TextEditingController passwordController}) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.msg_require_password.tr;
    }
    if (value.length < 8) {
      return LocaleKeys.min_password_msg.tr;
    }

    if (value != passwordController.text.toString()) {
      return LocaleKeys.identique_password_error.tr;
    }
    return null;
  }

  // Phone number validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.msg_phone_require.tr;
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
