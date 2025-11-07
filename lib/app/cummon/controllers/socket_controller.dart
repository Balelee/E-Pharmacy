import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pharmix/app/core/websocket/echo_service.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/auxiliaire_request.dart';
import 'package:pharmix/app/data/models/request_pharmacy.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/client/clientFeedBackRequest/controllers/client_feed_back_request_controller.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;
  final AuthProvider authProvider = AuthProvider();

  void _logoutUser() async {
    await authProvider.logout().then((value) {
      if (value) {
        if (Get.isRegistered<UserController>()) {
          Get.delete<UserController>();
        }
        SocketController socketController = Get.find<SocketController>();

        Get.find<UserRepository>().clearUser();
        var channels =
            socketController.echo!.connector.channels.values.toList();
        for (var chanel in channels) {
          socketController.echo!.connector.leaveChannel(chanel.name);
        }
        socketController.echo!.connector.disconnect();
        socketController.echo = null;
        Get.offAllNamed(AppPages.LOGINCONTENT);
      }
    });
  }

  void listenToNewLoggining({required int userId}) async {
    ecouter(
        channel: 'private-user.$userId',
        event: 'user.logged_in',
        action: (e) {
          print("double authentification");
          print(e);

          if (Get.isDialogOpen == true) {
            Get.back();
            DialogHelper.showConfirmationDialog(
                title: "Tentative d'auth",
                message: "${e['message']} par l'appareil ${e['device']} ",
                onConfirm: () {
                  _logoutUser();
                });
            return;
          }
          DialogHelper.showConfirmationDialog(
              title: "Tentative d'auth",
              message: "${e['message']} par ${e['user']['name']} ",
              onConfirm: () {
                _logoutUser();
              });
        });
  }

  void listenToNewRequestAdding({required int pharmacieId}) async {
    PharmacienController pharmacienController =
        Get.find<PharmacienController>();
    ecouter(
        channel: 'private-pharmacy.$pharmacieId',
        event: 'produit.demande',
        action: (e) {
          if (e != null) {
            AuxiliaireRequest request =
                AuxiliaireRequest.fromJson(e['request']);
            pharmacienController.requests.add(request);
          }
        });
  }

  void listenToMyRequestTraitement({required int requestId}) async {
    ClientFeedBackRequestController clientFeedBackRequestController =
        Get.find<ClientFeedBackRequestController>();
    clientFeedBackRequestController.startProcessingRequest();
    ecouter(
        channel: 'private-client.$requestId',
        event: 'commande.statut',
        action: (e) {
          final requestPharmacy =
              RequestPharmacy.fromJson(e['requestPharmacy']);
          clientFeedBackRequestController.addRequest(requestPharmacy);
        });
    ecouter(
        channel: 'private-pharmacy-count.$requestId',
        event: 'commande.traitement.count',
        action: (e) {
          print("commande.traitement.count $e");
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
      listenToNewRequestAdding(pharmacieId: user.pharmacie!.id ?? 0);
    }
    listenToNewLoggining(userId: user.id!);
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
