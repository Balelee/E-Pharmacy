import 'dart:async';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order_detail.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/data/models/order_pharmacy_detail.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/modules/home/controllers/cart_controller.dart';
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

  void loadOrder() {
    var oderLoad = [
      OrderPharmacy(
        id: 1,
        orderId: 12,
        pharmacyId: 1,
        status: "enattente",
        pharmacy: Pharmacy(
          id: 1,
          name: "Camille",
          latitude: "12.37579",
          longitude: "-1.47883",
        ),
        details: [
          OrderPharmacyDetail(
            id: 2,
            orderDetailId: 4,
            available: true,
            quantity: 2,
            price: 1000,
            total: 2000,
            orderDetails: OrderDetail(productName: "Paracetamol"),
          )
        ],
      ),
      OrderPharmacy(
        id: 1,
        orderId: 23,
        pharmacyId: 12,
        status: "expiré",
        pharmacy: Pharmacy(
          id: 1,
          name: "Benia",
          latitude: "12.37579",
          longitude: "-1.47883",
        ),
        details: [
          OrderPharmacyDetail(
            id: 2,
            orderDetailId: 4,
            available: true,
            quantity: 1,
            price: 1200,
            total: 1200,
            orderDetails: OrderDetail(
              productName: "Doliprane",
            ),
          ),
          OrderPharmacyDetail(
            id: 2,
            orderDetailId: 4,
            available: true,
            quantity: 1,
            price: 2500,
            total: 2500,
            orderDetails: OrderDetail(productName: "Fivrerr"),
          )
        ],
      ),
    ].obs;
    orders.value = oderLoad;
  }

  void getUserPosition() async {
    final userPosition = await locationHelper.allowPermission();
    await Future.wait(orders.map((order) async {
      final pharmacy = order.pharmacy;
      final latitude = double.tryParse(pharmacy.latitude.toString()) ?? 0.0;
      final longitude = double.tryParse(pharmacy.longitude.toString()) ?? 0.0;
      final distanceKm = await locationHelper.calculateDistanceKm(
        userPosition?.latitude ?? 0,
        userPosition?.longitude ?? 0,
        latitude,
        longitude,
      );
      distances[order.id] = distanceKm;
    }));
  }

  @override
  void onInit() {
    super.onInit();
    loadOrder();
    getUserPosition();
    // startProcessingOrder();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
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
