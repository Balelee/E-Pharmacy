import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/pharmacies_controller.dart';

class PharmaciesView extends GetView<PharmaciesController> {
  const PharmaciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: BackButton(
          color: AppColors.background,
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          text: "Pharmacies à proximité",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.local_pharmacy,
                color: AppColors.background,
              )),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.showToast.value
                  ? CustomToast(
                      icon: Icons.info_outline,
                      message:
                          "Trouvez les pharmacies les plus proches en saisissant leur nom dans la barre de recherche.",
                      backgroundColor: AppColors.primary.withOpacity(0.6),
                      onClose: () {
                        controller.showToast.value = false;
                      },
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 15),
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
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'garde',
                          child: Text(
                            'Pharmacie de garde',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'normal',
                          child: Text(
                            'Toutes les pharmacies',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                      onSelected: (value) async {
                        if (value == 'garde') {
                          controller.listTitle.value = "Pharmacie de garde";
                          controller.isGardeMode.value = true;
                          await controller.loadPharmaciesDeGarde();
                        } else if (value == 'normal') {
                          controller.listTitle.value = "Liste des pharmacies";
                          controller.isGardeMode.value = false;
                          controller.loadPharmacies(isRefresh: true);
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: controller.listTitle.value,
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
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: controller.hasSearched.value &&
                        controller.pharmacies.isEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/no_data.png',
                                width: Get.width / 2,
                                fit: BoxFit.contain,
                              ),
                              CustomText(
                                text:
                                    "Aucune pharmacie trouvée pour votre recherche",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.pharmacies.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.pharmacies.length) {
                            final pharmacy = controller.pharmacies[index];
                            final todayHours =
                                pharmacy.getOpeningHoursForToday();
                            final avatarColor = controller.avatarColors[
                                index % controller.avatarColors.length];
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
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: avatarColor,
                                    radius: 25,
                                    child: Text(
                                      controller
                                          .getInitials(pharmacy.pharmacieName),
                                      style: const TextStyle(
                                        color: AppColors.background,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: pharmacy.pharmacieName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            if (controller.isGardeMode.value)
                                              CustomText(
                                                  text: "De garde",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.error,
                                                  ))
                                            else
                                              CustomText(
                                                text: pharmacy.isOpenNow
                                                    ? "Ouvert"
                                                    : "Fermé",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: pharmacy.isOpenNow
                                                      ? Colors.green.shade300
                                                      : AppColors.error,
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          text: pharmacy.adresse,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (!controller.isGardeMode.value)
                                          if (todayHours != null)
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "${todayHours.day}: ",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                CustomText(
                                                  text:
                                                      "${todayHours.openingTime} - ${todayHours.closingTime}",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.error
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            )
                                          else
                                            CustomText(
                                              text: "Dimanche - Fermé",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.error
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  CustomText(
                                                    text: pharmacy.phone,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                launchUrl(Uri.parse(
                                                    "tel:${pharmacy.phone}"));
                                              },
                                            ),
                                            OutlinedButton.icon(
                                              onPressed: () async {
                                                final lat = pharmacy.latitude;
                                                final lng = pharmacy.longitude;
                                                if (lat != null &&
                                                    lng != null) {
                                                  controller.openMap(lat, lng);
                                                }
                                              },
                                              icon: const Icon(
                                                  Icons.map_rounded,
                                                  size: 16),
                                              label: const Text("Localisation"),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.green,
                                                side: const BorderSide(
                                                  color: Colors.green,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
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
                          }
                          if (controller.searchText.value.isEmpty &&
                              !controller.isLastPage.value &&
                              controller.isLoadingMore.value &&
                              controller.pharmacies.isNotEmpty) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
