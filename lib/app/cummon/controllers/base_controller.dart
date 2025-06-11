import 'package:get/get.dart';
import 'package:pharmix/app/core/network/api_exception.dart';
import '../../utils/helpers/dialog_helper.dart';

mixin BaseController {
  void handleError(error) {
    hideLoading();
    print(error);
    if (error is ApiException) {
      var message = error.message;
      displayErrorDialog(message: message!);
    } else {
      displayErrorDialog(message: 'Erreur inconnu!');
    }
  }

  showLoading({String? message, bool noBkgColor = false}) {
    DialogHelper.showLoading(message: message, noBkgColor: noBkgColor);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  displayErrorDialog({required String message}) {
    DialogHelper.showErrorSnackbar(message: message);
  }

  displaySuccesMessage(
      {required String message,
      void Function()? onConfirmBtnTap,
      bool? barrierDismissible}) {
    DialogHelper.showSuccessSnackbar(message: message.tr);
  }

  displayConfirmationDialog(
      {required String title,
      required String message,
      required Function() onConfirm,
      required Function() onCancel}) {
    DialogHelper.confirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        onCancel: onCancel);
  }
}
