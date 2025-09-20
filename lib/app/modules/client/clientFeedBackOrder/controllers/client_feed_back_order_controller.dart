import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';

class ClientFeedBackOrderController extends GetxController {
  final orders = <OrderPharmacy>[].obs;
  RxBool isProcessing = false.obs;
  RxInt processingSeconds = 0.obs;
  CartController cartController = Get.put(CartController());
  RxMap<int, double> distances = <int, double>{}.obs;
  LocationHelper locationHelper = LocationHelper();

  Timer? timer;
  final List<String> processingMessages = [
    "Les pharmacies proches examinent votre commande.",
    "Nous vérifions la disponibilité des produits.",
    "Préparation en cours, merci de patienter.",
  ];

  RxInt totalPharfeedbackOrder = RxInt(0);
  RxInt get successPhaReponse => RxInt(orders.length);

  String formatDistance(double km) {
    if (km < 1) {
      return "${(km * 1000).toInt()} m";
    } else {
      return "${km.toStringAsFixed(1)} km";
    }
  }

  void startTrackingUser() async {
    await locationHelper.allowPermission();
    locationHelper.positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((userPosition) async {
      for (final order in orders) {
        final pharmacy = order.pharmacy;
        final latitude = double.tryParse(pharmacy!.latitude.toString()) ?? 0.0;
        final longitude = double.tryParse(pharmacy.longitude.toString()) ?? 0.0;

        final distanceKm = await locationHelper.calculateDistanceKm(
          userPosition.latitude,
          userPosition.longitude,
          latitude,
          longitude,
        );

        distances[order.id] = distanceKm;
      }
      distances.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTrackingUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    locationHelper.positionStream?.cancel();
    super.onClose();
  }

  void startProcessingOrder() {
    isProcessing.value = true;
    processingSeconds.value = 0;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      processingSeconds.value++;
    });
  }

  void addOrder(OrderPharmacy orderPharmacy) {
    orders.insert(0, orderPharmacy);
    totalPharfeedbackOrder.value = orderPharmacy.treated_count;
    isProcessing.value = false;
    timer?.cancel();
  }

  String get currentProcessingMessage {
    int index = (processingSeconds.value ~/ 4) % processingMessages.length;
    return processingMessages[index];
  }

  String get elapsedTime {
    int seconds = processingSeconds.value;
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }
}
