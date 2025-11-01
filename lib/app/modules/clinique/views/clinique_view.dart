import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/clinique_controller.dart';

class CliniqueView extends GetView<CliniqueController> {
  const CliniqueView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: BackButton(
          color: AppColors.background,
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          text: LocaleKeys.appbar_clinique_title.tr,
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
                Icons.local_hospital,
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
                      message: LocaleKeys.toast_clinique.tr,
                      action: CustomButton.primaryButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        onPressed: () {},
                        buttonTitle: LocaleKeys.ajouter.tr,
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.background,
                        ),
                      ),
                      backgroundColor: Colors.green.withOpacity(0.6),
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
                            color: AppColors.primary.withOpacity(0.2),
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
                          hintText: LocaleKeys.search_clinique_title.tr,
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(
                              Icons.search,
                              color: AppColors.primary,
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
                          color: AppColors.primary.withOpacity(0.2),
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
                          value: 'clinic',
                          child: Text(
                            LocaleKeys.clinique.tr,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'labo',
                          child: Text(
                            LocaleKeys.laboratoire.tr,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                      onSelected: (value) async {
                        if (value == 'clinic') {
                          controller.listTitle.value =
                              LocaleKeys.liste_clinique.tr;
                          controller.isGardeMode.value = true;
                          // await controller.loadPharmaciesDeGarde();
                        } else if (value == 'labo') {
                          controller.listTitle.value =
                              LocaleKeys.list_laboratoire.tr;
                          controller.isGardeMode.value = false;
                          // controller.loadPharmacies(isRefresh: true);
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
                          color: AppColors.primary.withOpacity(0.2),
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
                        controller.sampleFacilities.isEmpty
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
                                text: LocaleKeys.introuvable_clinique.tr,
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
                        itemCount: controller.sampleFacilities.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.sampleFacilities.length) {
                            final samplefacilities =
                                controller.sampleFacilities[index];
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
                                          .getInitials(samplefacilities.name),
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
                                              text: samplefacilities.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            // CustomText(
                                            //   text: samplefacilities.isOpenNow
                                            //       ? "Ouvert"
                                            //       : "Fermé",
                                            //   style: TextStyle(
                                            //     fontSize: 13,
                                            //     fontWeight: FontWeight.bold,
                                            //     color:
                                            //         samplefacilities.isOpenNow
                                            //             ? Colors.green.shade300
                                            //             : AppColors.error,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          text: samplefacilities.address,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    color: AppColors.primary,
                                                    size: 20,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        samplefacilities.phone,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                launchUrl(Uri.parse(
                                                    "tel:${samplefacilities.phone}"));
                                              },
                                            ),
                                            OutlinedButton.icon(
                                              onPressed: () async {
                                                final lat =
                                                    samplefacilities.latitude;
                                                final lng =
                                                    samplefacilities.longitude;
                                                if (lat != null &&
                                                    lng != null) {
                                                  controller.openMap(lat, lng);
                                                }
                                              },
                                              icon: const Icon(
                                                  Icons.map_rounded,
                                                  size: 16),
                                              label: Text(
                                                  LocaleKeys.localisation.tr),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor:
                                                    AppColors.primary,
                                                side: const BorderSide(
                                                  color: AppColors.primary,
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
