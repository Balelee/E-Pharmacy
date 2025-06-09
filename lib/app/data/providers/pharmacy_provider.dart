import 'package:e_pharma/app/cummon/controllers/base_controller.dart';
import 'package:e_pharma/app/data/models/pharmacy.dart';
import 'package:e_pharma/app/data/providers/api_provider.dart';
import 'package:e_pharma/app/utils/enums/api_routes.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';

class PharmacyProvider with BaseController {
  Future<List<Pharmacy>> fetchPharmacies(
      {required int pageKey, String? query}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.pharmacies
            .format({'pageKey': pageKey.toString(), 'query': query}),
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<Pharmacy> pharmaciesList =
            data.map((json) => Pharmacy.fromJson(json)).toList();
        return pharmaciesList;
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }
}
