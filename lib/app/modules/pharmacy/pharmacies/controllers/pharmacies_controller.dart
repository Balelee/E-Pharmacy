import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/Location_helper.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'dart:math' as math;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PharmaciesController extends GetxController {
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;
  List<Pharmacy> allPharmaciesLoaded = [];
  final pharmacyProvider = PharmacyProvider();
  final RxInt currentPage = 1.obs;

  final TextEditingController searchController = TextEditingController();
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
    Colors.purple
  ];

  RxList<TypeModel> pharmacyStatus = RxList([]);
  Rxn<TypeModel> selectedStatus = Rxn();
  bool _isFetching = false;
  bool _hasLoadedFirstPage = false;
  late final PagingController<int, Pharmacy> pagingController;
  RxnString query = RxnString(null);
  final RxBool _isDisposed = RxBool(false);
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserLocation();
    });
    if (pharmacyStatus.isEmpty) {
      loadPharmaciesTypes();
    }

    _initPagingController();
  }

  void fetchResearchData({required String? label}) async {
    query.value = label;
    _performSearch();
  }

  Future<void> _performSearch() async {
    if (!_isDisposed.value) {
      _hasLoadedFirstPage = false;
      _isFetching = false;
      pagingController.cancel();
      pagingController.refresh();
    }
  }

  @override
  void onClose() {
    _isDisposed.value = true;
    searchController.dispose();
    super.onClose();
  }

  void refresh() => pagingController.refresh();

  void updatePharmacyStatus(TypeModel status) async {
    selectedStatus.value = status;
    // Réinitialiser les indicateurs avant de recharger
    _hasLoadedFirstPage = false;
    _isFetching = false;
    pagingController.cancel();
    pagingController.refresh();
  }

  void loadPharmaciesTypes() async {
    pharmacyStatus.value = await pharmacyProvider.loadPharmacieCategories();
    selectedStatus.value = pharmacyStatus.first;
  }

  void _initPagingController() {
    pagingController = PagingController<int, Pharmacy>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchPage,
    );
  }

  Future<List<Pharmacy>> _fetchPage(int pageKey) async {
    print(selectedStatus.value?.filter);
    await getUserLocation();
    if (_hasLoadedFirstPage && pageKey == 1) {
      return [];
    }

    if (_isFetching) return [];
    _isFetching = true;
    final newItems = await pharmacyProvider.fetchPharmacies(
        pageKey: pageKey,
        query: query.value,
        userPosition: userPosition.value,
        isOnDuty: int.parse(selectedStatus.value?.filter ?? "0"));

    _isFetching = false;
    _hasLoadedFirstPage = true;
    return newItems;
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
      // await updateDistancesAndSort();
    });
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
