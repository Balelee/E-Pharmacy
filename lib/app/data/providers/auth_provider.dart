import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/base_controller.dart';
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
      final response = await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.login.path,
        data: {'email': email, 'password': password},
      ).catchError(handleError);
      hideLoading();
      if (response != null) {
        Token.saveAuthToken(response['data']['token']);
        User user = User.fromJson(response['data']);
        await Get.find<UserRepository>().saveUser(user);
        return user;
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "Erreur de connexion: $e");
      return null;
    }
  }

  Future<User?> signUp(User user) async {
    try {
      final response = await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.register.path,
        data: user.toJson(),
      ).catchError(handleError);
      if (response != null) {
        final newUser = User.fromJson(response['data']);
        return newUser;
      }
      return null;
    } catch (e) {
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
