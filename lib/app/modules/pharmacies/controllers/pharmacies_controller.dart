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
  int currentPage = 1;
  RxBool isLastPage = false.obs;
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool hasSearched = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadPharmacies(pageKey: currentPage);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPharmacies();
    });
    debounce(searchText, (value) {
      hasSearched.value = value.isNotEmpty;
      loadPharmacies(query: value, isRefresh: true);
    }, time: const Duration(milliseconds: 500));
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  String getCurrentDayName() {
    return DateFormat('EEEE', 'fr_FR').format(DateTime.now());
  }

  Future<void> loadPharmacies({
    int pageKey = 1,
    String? query,
    bool isRefresh = false,
  }) async {
    if (isLoadingMore.value) return;

    if (isLastPage.value && !isRefresh) return;
    if (isRefresh) {
      currentPage = 1;
      isLastPage.value = false;
      pharmacies.clear();
    }

    isLoadingMore.value = true;

    if (pageKey == 1) {
      DialogHelper.showLoading(
        message: "Patienter...",
        noBkgColor: false,
        colorProgress: Colors.green,
        messageStyle: const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    try {
      final result = await pharmacyProvider.fetchPharmacies(
        pageKey: pageKey,
        query: query,
      );

      if (result.isEmpty) {
        isLastPage.value = true;
      } else {
        if (isRefresh) {
          pharmacies.assignAll(result);
        } else {
          pharmacies.addAll(result);
        }
        currentPage++;
      }
    } finally {
      isLoadingMore.value = false;
      if (pageKey == 1) {
        DialogHelper.hideLoading();
      }
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
