import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';

class PharmaciesController extends GetxController {
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;
  final pharmacyProvider = PharmacyProvider();
  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;
  final RxString listTitle = LocaleKeys.liste_pharmacies.tr.obs;
  final RxBool isGardeMode = false.obs;
  RxBool isNameAsc = true.obs;
  Rx<Color> iconColor = AppColors.textSecondary.obs;
  int currentPage = 1;
  RxBool isLastPage = false.obs;
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool hasSearched = false.obs;
  final RxBool showToast = true.obs;

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
        message: LocaleKeys.patienter.tr,
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

  Future<void> loadPharmaciesDeGarde() async {
    DialogHelper.showLoading(
      message: LocaleKeys.charger_mes_pharmacie.tr,
      noBkgColor: false,
      colorProgress: Colors.green,
      messageStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
    try {
      final result = await pharmacyProvider.fetchPharmaciesDeGarde();
      pharmacies.assignAll(result);
      isLastPage.value = true;
      hasSearched.value = false;
      currentPage = 1;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "${LocaleKeys.error.tr}: $e");
    } finally {
      DialogHelper.hideLoading();
    }
  }

  void sortByName() {
    isNameAsc.value = !isNameAsc.value;
    pharmacies.sort((a, b) =>
        isNameAsc.value ? a.name!.compareTo(b.name!) : b.name!.compareTo(a.name!));
    iconColor.value = iconColor.value == AppColors.textSecondary
        ? Colors.green
        : AppColors.textSecondary;
    pharmacies.refresh();
  }

  String getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      final secondWord = parts[1];
      return secondWord.length >= 2
          ? secondWord.substring(0, 2).toUpperCase()
          : secondWord.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }

  final List<Color> avatarColors = [
    AppColors.success,
    AppColors.primary,
    Colors.orange,
    AppColors.error,
    Colors.purple,
  ];
}
