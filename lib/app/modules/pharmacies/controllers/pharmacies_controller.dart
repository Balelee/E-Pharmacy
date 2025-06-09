import 'package:e_pharma/app/data/models/pharmacy.dart';
import 'package:e_pharma/app/data/providers/pharmacy_provider.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/utils/helpers/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmaciesController extends GetxController {
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;
  final pharmacyProvider = PharmacyProvider();
  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;
  RxBool isNameAsc = true.obs;
  Rx<Color> iconColor = AppColors.textSecondary.obs;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPharmacies();
    });

    debounce(searchText, (value) {
      loadPharmacies(query: value);
    }, time: const Duration(milliseconds: 500));
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  String getCurrentDayName() {
    return DateFormat('EEEE', 'fr_FR').format(DateTime.now());
  }

  Future<void> loadPharmacies({int pageKey = 1, String? query}) async {
    DialogHelper.showLoading(
      message: "Patienter...",
      noBkgColor: false,
      colorProgress: Colors.green,
      messageStyle: const TextStyle(fontWeight: FontWeight.bold),
    );

    try {
      final result = await pharmacyProvider.fetchPharmacies(
          pageKey: pageKey, query: query);
      pharmacies.value = result;
    } finally {
      DialogHelper.hideLoading();
    }
  }

  void openMap(String lat, String lng) async {
    final googleMapsUrl = Uri.parse("comgooglemaps://?q=$lat,$lng");
    final webUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Erreur", "Impossible d’ouvrir Google Maps.");
    }
  }

  void sortByName() {
    isNameAsc.value = !isNameAsc.value;
    pharmacies.sort((a, b) => isNameAsc.value
        ? a.pharmacieName.compareTo(b.pharmacieName)
        : b.pharmacieName.compareTo(a.pharmacieName));
    iconColor.value = iconColor.value == AppColors.textSecondary
        ? Colors.green
        : AppColors.textSecondary;
    pharmacies.refresh();
  }
}
