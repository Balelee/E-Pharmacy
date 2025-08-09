import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pharmix/app/core/websocket/echo_service.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;

  void listenToNewProductAdding() async {
    // ProductController productController = Get.find<ProductController>();
    ecouter(
        channel: 'private-new-product',
        event: 'newProduct-event',
        action: (e) {});
  }

  void listenToProductUpdated() async {
    ecouter(
        channel: 'private-product.updated',
        event: 'updateProduct-event',
        action: (e) {});
  }

  void listenToProductDeleted() async {
    ecouter(
        channel: 'private-product.delete',
        event: 'deleteProduct-event',
        action: (e) {});
  }

  Future<void> connectToSocket() async {
    try {
      echo ??= await EchoService.initEcho();
      echo!.connector.onConnect((data) {
        initialSoketSubcription();
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "socket error: $e");
    }
  }

  Future<void> initialSoketSubcription() async {
    // listenToNewProductAdding();
    // listenToProductUpdated();
    // listenToProductDeleted();
  }

  void ecouter(
      {required String channel,
      required String event,
      required Function action}) {
    EchoService.listen(
      echo: echo!,
      channel: channel,
      event: event,
      action: action,
    );
  }
}
