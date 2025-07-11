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
}


