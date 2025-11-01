import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';

class AuxilliaireProvider with BaseController {
  Future<bool> storeResponse(
      {required int requestId, required Map<String, dynamic> data}) async {
    try {
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.requestResponse.format({"requestId": requestId}),
        data: data,
      ).catchError(handleError);
      hideLoading();

      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      hideLoading();
      return false;
    }
  }
}
