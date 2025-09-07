import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pharmix/app/core/websocket/echo_service.dart';
import 'package:pharmix/app/data/models/auxiliaire_order.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/modules/client/clientFeedBackOrder/controllers/client_feed_back_order_controller.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;

  void listenToNewOrderAdding({required int pharmacieId}) async {
    PharmacienController pharmacienController =
        Get.find<PharmacienController>();
    ecouter(
        channel: 'private-pharmacy.$pharmacieId',
        event: 'produit.demande',
        action: (e) {
          if (e != null) {
            AuxiliaireOrder order = AuxiliaireOrder.fromJson(e['order']);
            pharmacienController.orders.add(order);
          }
        });
  }

  void listenToMyOrderTraitement({required int orderId}) async {
    ClientFeedBackOrderController clientFeedBackOrderController =
        Get.find<ClientFeedBackOrderController>();
    clientFeedBackOrderController.startProcessingOrder();
    ecouter(
        channel: 'private-client.$orderId',
        event: 'commande.statut',
        action: (e) {
          final orderPharmacy = OrderPharmacy.fromJson(e['orderPharmacy']);
          clientFeedBackOrderController.addOrder(orderPharmacy);
        });
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

  Future<void> connectToSocket({required User user}) async {
    try {
      echo ??= await EchoService.initEcho();
      echo!.connector.onConnect((data) {
        initialSoketSubcription(user: user);
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "socket error: $e");
    }
  }

  Future<void> initialSoketSubcription({required User user}) async {
    if (user.pharmacie != null) {
      listenToNewOrderAdding(pharmacieId: user.pharmacie!.id ?? 0);
    }
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
