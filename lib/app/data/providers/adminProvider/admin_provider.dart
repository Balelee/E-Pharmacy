import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class AdminProvider with BaseController {
  Future<List<User>> fetchUsers() async {
    try {
      final response =
          await ApiProvider.get(auth: true, apiURL: ApiRoutes.adminUsers.path)
              .catchError(handleError);
      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<User> pharmaciesList =
            data.map((json) => User.fromJson(json)).toList();
        return pharmaciesList;
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }

  Future<bool> updateUserData(
      {required String userId, required Map<String, Object?> data}) async {
    try {
      final response = await ApiProvider.put(
              auth: true,
              data: data,
              apiURL: ApiRoutes.adminUpdateUsers.format({"user": userId}))
          .catchError(handleError);

      return (response != null && response['data'] != null);
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return false;
    }
  }
}
