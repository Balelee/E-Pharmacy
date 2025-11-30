import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/data/enums/request_status_enum.dart';
import 'package:pharmix/app/data/models/request_pharmacy.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/data/providers/request_provider.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';

class ClientFeedBackRequestController extends GetxController {
  final ProductProvider produitProvider = ProductProvider();
  final RequestProvider requestProvider = RequestProvider();
  final responses = <RequestPharmacy>[].obs;
  Rxn<TypeModel> requestStatus = Rxn<TypeModel>();
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
  RxInt get successPhaReponse => RxInt(responses.length);
  final RxBool _isDisposed = RxBool(false);
  late final PagingController<int, RequestPharmacy> pagingController;
  bool _isFetching = false;
  bool _hasLoadedFirstPage = false;
  @override
  void onInit() {
    super.onInit();

    _initPagingController();
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
    _isDisposed.value = true;
  }

  void _initPagingController() {
    pagingController = PagingController<int, RequestPharmacy>(
      getNextPageKey: (state) {
        final totalLoaded = state.items?.length ?? 0;
        if (totalLoaded == 0) return 1;
        if (totalLoaded % 10 != 0) return null;
        return state.nextIntPageKey;
      },
      fetchPage: _fetchPage,
    );
  }

  Future<List<RequestPharmacy>> _fetchPage(int pageKey) async {
    String? requestId = Get.arguments["requestId"];
    requestStatus.value = Get.arguments["status"];

    if (requestStatus.value?.filter == RequestStatusEnum.enattente.value) {
      startProcessingRequest(DateTime.parse(Get.arguments["created_at_value"]));
    }
    if (requestId == null) return [];
    if (_hasLoadedFirstPage && pageKey == 1) {
      return [];
    }
    if (_isFetching) return [];
    _isFetching = true;
    final newItems = await requestProvider.fetchClientRequestResponses(
      requestId: requestId,
      pageKey: pageKey,
    );
    _isFetching = false;
    _hasLoadedFirstPage = true;
    responses.addAll(newItems);

    /// 🔥 Très important -> recalcul des distances
    if (locationHelper.currentPosition != null) {
      updateDistances(locationHelper.currentPosition!);
    }
    return newItems;
  }

  String formatDistance(double km) {
    if (km < 1) {
      return "${(km * 1000).toInt()} m";
    } else {
      return "${km.toStringAsFixed(1)} km";
    }
  }

  Future<void> updateDistances(Position userPosition) async {
    if (responses.isEmpty) return;

    for (final request in responses) {
      final pharmacy = request.pharmacy;
      if (pharmacy == null) continue;

      final latitude = double.tryParse(pharmacy.latitude.toString()) ?? 0.0;
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
  }

  void startTrackingUser() async {
    await locationHelper.allowPermission();

    locationHelper.positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      locationHelper.currentPosition = position;
      await updateDistances(position);
    });
  }

  void startProcessingRequest(DateTime createdAt) {
    isProcessing.value = true;
    final now = DateTime.now();
    processingSeconds.value = now.difference(createdAt).inSeconds;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      processingSeconds.value++;
    });
  }

  void stopProcessingRequest() {
    isProcessing.value = false;
    processingSeconds.value = 0;
    timer?.cancel();
  }

  void addRequest(RequestPharmacy requestPharmacy) {
    responses.insert(0, requestPharmacy);
    totalPharfeedbackRequest.value = requestPharmacy.treated_count;
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
