import 'package:e_pharma/app/cummon/controllers/base_controller.dart';
import 'package:e_pharma/app/data/models/auth_message.dart';
import 'package:e_pharma/app/data/models/token.dart';
import 'package:e_pharma/app/data/models/user.dart';
import 'package:e_pharma/app/data/providers/api_provider.dart';
import 'package:e_pharma/app/utils/enums/api_routes.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider with BaseController {
  Future<AuthMessage?> login({
    required String phone,
    required String password,
    ValueSetter? error,
  }) async {
    try {
      showLoading();
      return await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.login.path,
        data: {'phone': phone, 'password': password},
      ).catchError(handleError).then((response) {
        hideLoading();
        if (response != null) {
          AuthMessage authMessage = AuthMessage.fromJson(response['infos']);
          return authMessage;
        }
        return null;
      });
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "Login error: $e");
      return null;
    }
  }

  Future<bool> verifyOtp({required String otp, required String phone}) async {
    try {
      showLoading();
      return await ApiProvider.post(
              auth: false,
              apiURL: ApiRoutes.verifyOtp.path,
              data: {'otp_code': otp, 'phone': phone})
          .catchError(handleError)
          .then((response) {
        hideLoading();
        if (response != null) {
          Token.saveAuthToken(response['data']['token']);
          User user = User.fromJson(response['data']);
          User.saveUser(user);
          return true;
        }
        return false;
      });
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "Verify otp error: $e");
      return false;
    }
  }

  // Future<Phone?> signUp({
  //   required String phone,
  //   required String password,
  //   required String confirmPassword,
  //   ValueSetter? error,
  // }) async {
  //   try {
  //     return await ApiProvider.post(
  //       auth: false,
  //       apiURL: ApiRoutes.register.path,
  //       data: {
  //         'phone': phone,
  //         'password': password,
  //         'password_confirmation': confirmPassword
  //       },
  //     ).catchError(handleError).then((response) {
  //       if (response != null) {
  //         Token.savePhoneToken(response['token']);
  //         Phone phone = Phone.fromJson(response['data']);
  //         Phone.savePhone(phone);
  //         return phone;
  //       }
  //       return null;
  //     });
  //   } catch (e) {
  //     DialogHelper.showErrorSnackbar(message: "Sign-up error: $e");
  //     return null;
  //   }
  // }

  Future<bool> logout() async {
    try {
      showLoading();
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.logout.path,
        data: {},
      ).catchError(handleError).then((response) {
        hideLoading();
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "Logout error: $e");
      return false;
    }
  }

  Future<bool> resendOtp({required int phoneId}) async {
    try {
      return await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.resendOtp.format({'phone_id': phoneId.toString()}),
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Resend otp error: $e");
      return false;
    }
  }
}
