import 'package:e_pharma/app/modules/home/controllers/dashboard_controller.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/widgets/service_card.dart';
import 'package:e_pharma/app/widgets/tip_card.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.welcome.tr,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF202938),
                          ),
                        ),
                        Text(
                          controller.userName,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF202938),
                                  ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0x1A202938),
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              size: 20),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 21,
                            height: 21,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              controller.notificationCount.value.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Services Section
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.our_services.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF202938),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.14,
                              children: [
                                ServiceCard(
                                  onTap: () {
                                    Get.offNamed(AppPages.PRODUIT_LIST);
                                  },
                                  icon: Icons.shopping_bag,
                                  label: LocaleKeys.marketplace.tr,
                                  color: Colors.blue,
                                ),
                                ServiceCard(
                                  onTap: () {
                                    Get.toNamed(AppPages.TRACKER_PERIOD);
                                  },
                                  icon: Icons.calendar_today,
                                  label: LocaleKeys.cycle.tr,
                                  color: Colors.pink,
                                ),
                                ServiceCard(
                                  onTap: () {},
                                  icon: Icons.pregnant_woman,
                                  label: LocaleKeys.pregnancy.tr,
                                  color: Colors.purple,
                                ),
                                ServiceCard(
                                  onTap: () {},
                                  icon: Icons.child_care,
                                  label: LocaleKeys.baby.tr,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Daily Tips Section
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.daily_tips.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF202938),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TipCard(
                              onTap: () {},
                              icon: Icons.favorite,
                              title: LocaleKeys.pregnancy_wellness.tr,
                              description:
                                  LocaleKeys.pregnancy_tip_description.tr,
                              color: Colors.pink,
                            ),
                            const SizedBox(height: 16),
                            TipCard(
                              onTap: () {},
                              icon: Icons.nightlight,
                              title: LocaleKeys.baby_sleep.tr,
                              description:
                                  LocaleKeys.baby_sleep_tip_description.tr,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
