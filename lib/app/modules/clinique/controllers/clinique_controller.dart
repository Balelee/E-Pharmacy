import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/data/models/medical_house.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CliniqueController extends GetxController {
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;
  final pharmacyProvider = PharmacyProvider();
  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;
  final RxString listTitle = "Liste des cliniques".obs;
  final RxBool isGardeMode = false.obs;
  RxBool isNameAsc = true.obs;
  Rx<Color> iconColor = AppColors.textSecondary.obs;
  int currentPage = 1;
  RxBool isLastPage = false.obs;
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool hasSearched = false.obs;

  final List<MedicalFacility> sampleFacilities = [
    MedicalFacility.fromJson({
      'id': 1,
      'name': 'Clinique La Vie',
      'address': '123 Avenue Zogona, Ouagadougou',
      'phone': '70 00 00 00',
      'latitude': '12.3456',
      'longitude': '-1.2345',
      'type': 'clinique',
    }),
    MedicalFacility.fromJson({
      'id': 2,
      'name': 'Laboratoire Médilab',
      'address': '456 Rue du Parc, Ouagadougou',
      'phone': '71 11 22 33',
      'latitude': '12.3467',
      'longitude': '-1.2367',
      'type': 'laboratoire',
    }),
    MedicalFacility.fromJson({
      'id': 3,
      'name': 'Clinique Espoir',
      'address': '789 Quartier Kamsonghin, Ouagadougou',
      'phone': '72 22 33 44',
      'latitude': '12.3490',
      'longitude': '-1.2389',
      'type': 'clinique',
    }),
  ];

  @override
  void onInit() {
    super.onInit();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 200) {
    //     loadPharmacies(pageKey: currentPage);
    //   }
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loadPharmacies();
    // });
    // debounce(searchText, (value) {
    //   hasSearched.value = value.isNotEmpty;
    //   loadPharmacies(query: value, isRefresh: true);
    // }, time: const Duration(milliseconds: 500));
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
    sampleFacilities.sort((a, b) =>
        isNameAsc.value ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    iconColor.value = iconColor.value == AppColors.textSecondary
        ? AppColors.primary
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
