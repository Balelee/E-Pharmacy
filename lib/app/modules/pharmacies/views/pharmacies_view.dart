import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/pharmacies_controller.dart';

class PharmaciesView extends GetView<PharmaciesController> {
  const PharmaciesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 80.0, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () => Get.back(),
                    color: Colors.green,
                  ),
                  const Text(
                    'Pharmacies à proximité',
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    "assets/images/pharmLogo.png",
                    width: 70,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    child: Container(
                      width: Get.width / 1.3,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        cursorHeight: 15,
                        controller: controller.searchController,
                        onChanged: (value) =>
                            controller.searchText.value = value.trim(),
                        decoration: InputDecoration(
                          hintText: "Tapez le nom de la pharmacie...",
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(
                              Icons.search,
                              color: Colors.green,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: PopupMenuButton<String>(
                      color: AppColors.background,
                      icon: Icon(
                        Icons.sort,
                        size: 25,
                        color: AppColors.textSecondary,
                      ),
                      onSelected: (value) {
                        if (value == 'garde') {}
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'garde',
                          child: Text(
                            'Pharmacie de garde',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Liste des pharmacies",
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.import_export,
                        size: 25,
                        color: controller.iconColor.value,
                      ),
                      onTap: () {
                        controller.sortByName();
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.pharmacies.length,
                  itemBuilder: (context, index) {
                    final pharmacy = controller.pharmacies[index];
                    final todayHours = pharmacy.getOpeningHoursForToday();
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_pharmacy,
                            color: Colors.green,
                            size: 30,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      pharmacy.pharmacieName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      pharmacy.isOpenNow ? "Ouvert" : "Fermé",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade300),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pharmacy.adresse,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (todayHours != null)
                                  Row(
                                    children: [
                                      Text(
                                        "${todayHours.day}: ",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        " ${todayHours.openingTime} - ${todayHours.closingTime}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              AppColors.error.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    "Dimanche - Fermé",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            AppColors.error.withOpacity(0.6)),
                                  ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          Text(
                                            pharmacy.phone,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        launchUrl(
                                            Uri.parse("tel:${pharmacy.phone}"));
                                      },
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () async {
                                        final lat = pharmacy.latitude;
                                        final lng = pharmacy.longitude;
                                        if (lat != null && lng != null) {
                                          controller.openMap(lat, lng);
                                        }
                                      },
                                      icon: const Icon(Icons.map_rounded,
                                          size: 16),
                                      label: const Text("Localisation"),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green,
                                        side: const BorderSide(
                                            color: Colors.green),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
