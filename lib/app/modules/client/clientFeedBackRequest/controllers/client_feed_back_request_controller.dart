import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request_pharmacy.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';

class ClientFeedBackRequestController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  final requests = <RequestPharmacy>[].obs;
  RxList<RequestTypeModel> requestStatus = RxList([]);
  Rxn<RequestTypeModel> selectedStatus = Rxn();
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

  RxInt totalPharfeedbackRequest = RxInt(0);
  RxInt get successPhaReponse => RxInt(requests.length);

  final RxBool _isDisposed = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    startTrackingUser();
    if (requestStatus.isEmpty) {
      loadTransactionsTypes();
    }
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
    _isDisposed.value = true;
  }

  void updateRequestStatus(RequestTypeModel status) async {
    selectedStatus.value = status;
    await produitProvider.fetchClientRequests(
        pageKey: 1, filter: selectedStatus.value?.filter);

    if (!_isDisposed.value) {}
  }

  void loadTransactionsTypes() async {
    requestStatus.value = [
      RequestTypeModel(label: "En attente", filter: 'attente', count: 3),
      RequestTypeModel(label: "Traités", filter: 'traite', count: 8),
      RequestTypeModel(label: "Annulées", filter: 'canceled', count: 3)
    ];
    selectedStatus.value = requestStatus.first;
  }

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
      for (final request in requests) {
        final pharmacy = request.pharmacy;
        final latitude = double.tryParse(pharmacy!.latitude.toString()) ?? 0.0;
        final longitude = double.tryParse(pharmacy.longitude.toString()) ?? 0.0;

        final distanceKm = await locationHelper.calculateDistanceKm(
          userPosition.latitude,
          userPosition.longitude,
          latitude,
          longitude,
        );

        distances[request.id] = distanceKm;
      }
      distances.refresh();
    });
  }

  void startProcessingRequest() {
    isProcessing.value = true;
    processingSeconds.value = 0;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      processingSeconds.value++;
    });
  }

  void addRequest(RequestPharmacy requestPharmacy) {
    requests.insert(0, requestPharmacy);
    totalPharfeedbackRequest.value = requestPharmacy.treated_count;
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
