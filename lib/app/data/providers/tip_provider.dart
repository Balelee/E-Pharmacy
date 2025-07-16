import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/tip.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class TipProvider with BaseController {
  Future<List<Tip>> loadTipsData() async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.tips.path,
      ).catchError(handleError);

      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<Tip> tips = data.map((json) => Tip.fromJson(json)).toList();
        return tips;
      }

      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Fetching error: $e");
      return [];
    }
  }

  Future<PillRemember?> storeRemenber(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.pillremember.path,
        data: data,
      ).catchError(handleError);
      hideLoading();
      if (response != null && response['data'] != null) {
        return PillRemember.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<List<PillRemember>> loadPillRemembers() async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.getremenbers.path,
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<PillRemember> reminders =
            data.map((json) => PillRemember.fromJson(json)).toList();
        return reminders;
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur de récupération: $e");
      return [];
    }
  }

  Future<bool> deletePillRemember(int id) async {
    try {
      final response = await ApiProvider.delete(
        auth: true,
        apiURL: '${ApiRoutes.getremenbers.path}/$id',
      );
      if (response != null && response['data'] != null) {
        return true;
      } else {
        DialogHelper.showErrorSnackbar(
            message: "Erreur lors de la suppression");
        return false;
      }
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Erreur réseau: $e");
      return false;
    }
  }

}
