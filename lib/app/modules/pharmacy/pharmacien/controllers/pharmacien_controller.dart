import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/cummon/controllers/socket_controller.dart';
import 'package:pharmix/app/cummon/controllers/user_controller.dart';
import 'package:pharmix/app/data/models/auxiliaire_order.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/data/providers/auth_provider.dart';
import 'package:pharmix/app/data/providers/auxilliaire_provider.dart';
import 'package:pharmix/app/data/providers/product_provider.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/utils/enums/order_status_enum.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class PharmacienController extends GetxController {
  AuxilliaireProvider auxilliaireProvider = AuxilliaireProvider();
  final AuthProvider authProvider = Get.put(AuthProvider());
  RxInt notificationCount = RxInt(3);
  final RxBool showToast = true.obs;
  final ScrollController scrollController = ScrollController();
  final user = UserController.to;
  static NavigationController get to => Get.find();
  var currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
  final ProductProvider produitProvider = ProductProvider();
  final RxList<AuxiliaireOrder> orders = <AuxiliaireOrder>[].obs;
  final RxList<OrderPharmacy> unwaitingsOrders = <OrderPharmacy>[].obs;
  final RxString selectedStatus = ''.obs;
  final RxBool isLoading = false.obs;
  void changePage(int index) {
    currentIndex.value = index;
  }

  Rx<OrderPharmacyStatusEnum> selectedOrderStatus =
      Rx(OrderPharmacyStatusEnum.enattente);

  void loadOrdersData() async {
    switch (selectedOrderStatus.value) {
      case OrderPharmacyStatusEnum.enattente:
        orders.value = await produitProvider.getOrdersPharmacies(
                orderPharmacyStatus: selectedOrderStatus.value,
                isLoading: isLoading.value) ??
            [];
        break;
      case OrderPharmacyStatusEnum.traite || OrderPharmacyStatusEnum.refused:
        unwaitingsOrders.value = await produitProvider.getOrdersTRPharmacies(
                orderPharmacyStatus: selectedOrderStatus.value) ??
            [];
        print(unwaitingsOrders.length);
        break;
      default:
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (orders.isEmpty || unwaitingsOrders.isEmpty) {
      loadOrdersData();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> storeOrderResponse(
      {required int orderId, required Map<String, dynamic> data}) async {
    bool response =
        await auxilliaireProvider.storeResponse(orderId: orderId, data: data);

    if (response) {
      final index = orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        orders.removeAt(index);
      }
    }
  }

  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");

  void setLoading({String loadMessage = "Loading..."}) {
    isLoding.value = true;
    loadingMessage.value = loadMessage;
  }

  void stopLoading() {
    isLoding.value = false;
    loadingMessage.value = "Loading...";
  }

  void logOut() {
    DialogHelper.confirmationDialog(
        title: LocaleKeys.confirm_title.tr,
        message: LocaleKeys.logout_message.tr,
        onCancel: () {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        },
        onConfirm: () async {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          setLoading(loadMessage: '');
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

            stopLoading();
          });
        });
  }
}
