import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/utils/helpers/map_helper.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/app/widgets/pharmacy_filter.dart';
import 'package:pharmix/app/widgets/request_filter.dart';
import 'package:pharmix/generated/locales.g.dart';
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
          text: LocaleKeys.appbar_pharamcy_page.tr,
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
                      message: LocaleKeys.msg_toast_pharmacie.tr,
                      backgroundColor: AppColors.primary.withOpacity(0.6),
                      onClose: () {
                        controller.showToast.value = false;
                      },
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: Container(
                  width: Get.width,
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
                      hintText: LocaleKeys.search_pharmacie_title.tr,
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
              const SizedBox(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     CustomText(
              //       text: controller.listTitle.value,
              //       style: TextStyle(
              //           color: AppColors.textSecondary,
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold),
              //     ),
              //     Container(
              //       width: 45,
              //       height: 45,
              //       decoration: BoxDecoration(
              //         color: AppColors.background,
              //         borderRadius: BorderRadius.circular(12),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.green.withOpacity(0.2),
              //             spreadRadius: 2,
              //             blurRadius: 6,
              //             offset: Offset(0, 1),
              //           ),
              //         ],
              //       ),
              //       child: GestureDetector(
              //         child: Icon(
              //           Icons.import_export,
              //           size: 25,
              //           color: controller.iconColor.value,
              //         ),
              //         onTap: () {
              //           controller.sortPharmacies(byDistance: true);
              //           ();
              //         },
              //       ),
              //     )
              //   ],
              // ),

              Container(
                decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: PharmacyFilterWidget(),
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
                                text: LocaleKeys.introuvable_pharmacie_msg.tr,
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
                    : PagingListener<int, Pharmacy>(
                        controller: controller.pagingController,
                        builder: (context, state, fetchNextPage) {
                          return PagedListView<int, Pharmacy>(
                            state: state,
                            fetchNextPage: fetchNextPage,
                            builderDelegate:
                                PagedChildBuilderDelegate<Pharmacy>(
                              itemBuilder: (context, pharmacy, index) {
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
                                              .getInitials(pharmacy.name ?? ''),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: pharmacy.name ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                                if (controller
                                                    .isGardeMode.value)
                                                  CustomText(
                                                      text: LocaleKeys
                                                          .de_garde.tr,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors.error,
                                                      ))
                                                else
                                                  CustomText(
                                                    text: pharmacy.isOpenNow!
                                                        ? LocaleKeys.ouvert.tr
                                                        : LocaleKeys.fermer.tr,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: pharmacy.isOpenNow!
                                                          ? Colors
                                                              .green.shade300
                                                          : AppColors.error,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            CustomText(
                                              text: pharmacy.adresse ?? "",
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
                                                      text:
                                                          "${todayHours.day}: ",
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors.error
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              else
                                                CustomText(
                                                  text: LocaleKeys
                                                      .sunday_fermer.tr,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.error
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        text: pharmacy.phone ??
                                                            "",
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
                                                    final lat =
                                                        pharmacy.latitude;
                                                    final lng =
                                                        pharmacy.longitude;
                                                    if (lat != null &&
                                                        lng != null) {
                                                      MapHelper.openMap(
                                                          lat, lng);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.map_rounded,
                                                      size: 16),
                                                  label: Text(
                                                    'Situé: ${pharmacy.distance}',
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.green,
                                                    side: const BorderSide(
                                                        color: Colors.green),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
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
                              firstPageProgressIndicatorBuilder: (_) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                              newPageProgressIndicatorBuilder: (_) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                              noMoreItemsIndicatorBuilder: (_) =>
                                  const Center(child: Text('Fin')),
                              firstPageErrorIndicatorBuilder: (_) =>
                                  Center(child: Text('Erreur: ')),
                              invisibleItemsThreshold: 5,
                            ),
                          );
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
