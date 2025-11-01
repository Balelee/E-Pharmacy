import 'package:geolocator/geolocator.dart';
import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class PharmacyProvider with BaseController {
  Future<List<Pharmacy>> fetchPharmacies({
    required int pageKey,
    String? query,
    Position? userPosition,
    int isOnDuty = 0,
  }) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.pharmacies.format({
          'pageKey': pageKey.toString(),
          'query': query,
          'lat': userPosition?.latitude,
          'lng': userPosition?.longitude,
          'is_on_duty': isOnDuty ,
        }),
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
