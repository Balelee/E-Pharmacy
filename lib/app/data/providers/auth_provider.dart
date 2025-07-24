import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/auth_message.dart';
import 'package:pharmix/app/data/models/token.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import '../repositories/user_repository.dart';

class AuthProvider with BaseController {
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      showLoading();
      final data = {
        'email': email,
        'password': password,
      };
      print("Avant appel post");
      final response = await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.login.path,
        data: data,
      
      );
      hideLoading();
      if (response != null) {
        print(response['data']);
        Token.saveAuthToken(response['data']['token']);
        User user = User.fromJson(response['data']);
        await Get.find<UserRepository>().saveUser(user);
        return user;
      }

      return null;
    } catch (e) {
      hideLoading();
      handleError(e);
      DialogHelper.showErrorSnackbar(message: "Erreur de connexion: $e");
      return null;
    }
  }

  Future<AuthMessage?> signUp(
      {required String phone, required String password}) async {
    try {
      showLoading();
      return await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.register.path,
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
      DialogHelper.showErrorSnackbar(message: "Sign-up error: $e");
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.logout.path,
        data: {},
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
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
