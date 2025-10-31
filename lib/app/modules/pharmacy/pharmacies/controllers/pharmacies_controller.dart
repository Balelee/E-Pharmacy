import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'dart:math' as math;

class PharmaciesController extends GetxController {
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;
  List<Pharmacy> allPharmaciesLoaded = [];
  ScrollController scrollController = ScrollController();
  final pharmacyProvider = PharmacyProvider();
  final RxInt currentPage = 1.obs;

  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;
  final RxString listTitle = LocaleKeys.liste_pharmacies.tr.obs;
  final locationHelper = LocationHelper();
  final RxBool isGardeMode = false.obs;
  RxBool isNameAsc = true.obs;
  RxBool isDistanceAsc = true.obs;
  Rx<Color> iconColor = AppColors.textSecondary.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLastPage = false.obs;
  RxBool hasSearched = false.obs;
  final RxBool showToast = true.obs;
  Rx<Position?> userPosition = Rx<Position?>(null);
  RxMap<int, double> distances = <int, double>{}.obs;

  final List<Color> avatarColors = [
    AppColors.success,
    AppColors.primary,
    Colors.orange,
    AppColors.error,
    Colors.purple,
  ];

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserLocation();
      await loadPharmacies();
      startTrackingUser();
    });

    scrollController.addListener(_onScroll);

    debounce(searchText, (value) {
      hasSearched.value = value.isNotEmpty;
      resetPagination();
      loadPharmacies(query: value);
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void resetPagination() {
    currentPage.value = 1;
    isLastPage.value = false;
    pharmacies.clear();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        !isLastPage.value) {
      loadPharmacies(query: searchText.value.isEmpty ? null : searchText.value);
    }
  }

  Future<void> getUserLocation() async {
    try {
      final position = await locationHelper.allowPermission();
      if (position != null) userPosition.value = position;
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: e.toString());
    }
  }

  void startTrackingUser() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      userPosition.value = position;
      await updateDistancesAndSort();
    });
  }

  double calculateDistanceKm(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        (math.cos((lat2 - lat1) * p) / 2) +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) /
            2;
    return 12742 * math.asin(math.sqrt(a));
  }

  Future<void> updateDistancesAndSort() async {
    if (userPosition.value == null) return;

    for (final pharmacy in allPharmaciesLoaded) {
      final lat = double.tryParse(pharmacy.latitude.toString()) ?? 0.0;
      final lng = double.tryParse(pharmacy.longitude.toString()) ?? 0.0;
      distances[pharmacy.id!] = calculateDistanceKm(
        userPosition.value!.latitude,
        userPosition.value!.longitude,
        lat,
        lng,
      );
    }

    allPharmaciesLoaded.sort((a, b) {
      final distA = distances[a.id!] ?? double.infinity;
      final distB = distances[b.id!] ?? double.infinity;
      return distA.compareTo(distB);
    });

    pharmacies.assignAll(allPharmaciesLoaded);
  }

  Future<void> loadPharmacies({String? query}) async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    isLastPage.value = false;

    bool shouldShowLoading = pharmacies.isEmpty;
    if (shouldShowLoading) {
      DialogHelper.showLoading(
        message: LocaleKeys.patienter.tr,
        noBkgColor: false,
        colorProgress: Colors.green,
        messageStyle: const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    try {
      int pageKey = 1;
      bool lastPage = false;

      if (allPharmaciesLoaded.isEmpty) {
        while (!lastPage) {
          final result = await pharmacyProvider.fetchPharmacies(
              pageKey: pageKey, query: query);
          if (result.isEmpty) {
            lastPage = true;
          } else {
            allPharmaciesLoaded.addAll(result);
            pageKey++;
          }
        }
      }

      await updateDistancesAndSort();

      isLastPage.value = true;
    } finally {
      isLoadingMore.value = false;
      if (shouldShowLoading && Get.isDialogOpen == true) {
        DialogHelper.hideLoading();
      }
    }
  }

  Future<void> loadPharmaciesDeGarde() async {
    bool shouldShowLoading = pharmacies.isEmpty;
    if (shouldShowLoading) {
      DialogHelper.showLoading(
        message: LocaleKeys.charger_mes_pharmacie.tr,
        noBkgColor: false,
        colorProgress: Colors.green,
        messageStyle: const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    try {
      final result = await pharmacyProvider.fetchPharmaciesDeGarde();
      allPharmaciesLoaded = result;
      pharmacies.assignAll(allPharmaciesLoaded);
      hasSearched.value = false;

      await updateDistancesAndSort();
      isLastPage.value = true;
    } finally {
      if (shouldShowLoading && Get.isDialogOpen == true) {
        DialogHelper.hideLoading();
      }
    }
  }

  void sortPharmacies({bool byDistance = false}) {
    if (byDistance) {
      isDistanceAsc.value = !isDistanceAsc.value;
      pharmacies.sort((a, b) {
        final distA = distances[a.id] ?? double.infinity;
        final distB = distances[b.id] ?? double.infinity;
        return isDistanceAsc.value
            ? distA.compareTo(distB)
            : distB.compareTo(distA);
      });
    } else {
      isNameAsc.value = !isNameAsc.value;
      pharmacies.sort((a, b) => isNameAsc.value
          ? a.name!.compareTo(b.name!)
          : b.name!.compareTo(a.name!));
    }

    iconColor.value = iconColor.value == Colors.green
        ? AppColors.textSecondary
        : Colors.green;
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

  String formatDistance(double? distance) {
    if (distance == null) return '-';
    if (distance >= 1) {
      return '${distance.toStringAsFixed(1)} km';
    } else {
      final meters = (distance * 1000).toStringAsFixed(0);
      return '${meters} m';
    }
  }
}
