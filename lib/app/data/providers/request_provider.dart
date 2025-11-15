import 'package:flutter/foundation.dart';
import 'package:pharmix/app/cummon/controllers/base_controller.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/api_provider.dart';
import 'package:pharmix/app/utils/enums/api_routes.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class RequestProvider with BaseController {
  Future<List<Request>> fetchClientRequests(
      {required int pageKey, String? query, String? filter}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.getUserRequests.format(
            {'pageKey': pageKey.toString(), 'query': query, 'filter': filter}),
      ).catchError(handleError);
      if (response != null && response['data'] != null) {
        print(response);
        final List<dynamic> data = response['data'];
        return data.map((json) => Request.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> newRequest(
      {required Map<String, dynamic> data}) async {
    try {
      showLoading();
      final response = await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.newUserRequests.path,
        data: data,
      ).catchError(handleError);
      hideLoading();
      if (response != null) {
        return response as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      hideLoading();
      DialogHelper.showErrorSnackbar(message: "fetching error: $e");
      return null;
    }
  }

  Future<void> cancelRequest({
    required String requestId,
    ValueSetter<String>? message,
  }) async {
    try {
      showLoading();
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.cancelUserRequests.format({"requestId": requestId}),
      ).catchError(handleError);
      hideLoading();
      if (response != null) {
        if (message != null) {
          message(response["message"]);
        }
      }
    } catch (e) {
      hideLoading();
    }
  }

  Future<List<TypeModel>> loadRequestStatus() async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.requestStats.path,
      ).catchError(handleError);
      if (response != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => TypeModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      hideLoading();
      return [];
    }
  }
}
