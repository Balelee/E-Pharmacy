import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/modules/home/views/profile_view.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/bottom_navigation_bar.dart';
import 'package:pharmix/app/widgets/service_card.dart';
import 'package:pharmix/app/widgets/tip_card.dart';
import 'package:pharmix/generated/locales.g.dart';

import '../controllers/pharmacien_controller.dart';

class PharmacienView extends GetView<PharmacienController> {
  const PharmacienView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageView(
          controller: NavigationController.to.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            NavigationController.to.currentIndex.value = index;
          },
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 20),
                    color: AppColors.background,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${LocaleKeys.welcome.tr} dans pharmacie",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF202938),
                              ),
                            ),
                            Text(
                              "${controller.user.user?.pharmacie?.pharmacieName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(
                                      0xFF202938,
                                    ),
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 22, left: 22, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nouveau",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF202938),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  controller.tips.isEmpty
                                      ? Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : CarouselSlider(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            enlargeCenterPage: true,
                                            viewportFraction: 1,
                                          ),
                                          items: controller.tips.map((tip) {
                                            return TipCard(
                                              onTap: () {},
                                              icon: tip.iconData,
                                              title: tip.title,
                                              description: tip.content,
                                              color: Colors.teal,
                                            );
                                          }).toList(),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Gestionnaire",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF202938),
                                ),
                              ),
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
                                      Get.toNamed(AppPages.ORDERPHARMACIEN);
                                    },
                                    leading: Image.asset(
                                      "assets/images/shop1.png",
                                      width: 35,
                                    ),
                                    label: 'Suivie commandes',
                                    color: Colors.blue,
                                  ),
                                  ServiceCard(
                                    onTap: () {
                                      // Get.toNamed(AppPages.ORDERPHARMACIEN);
                                    },
                                    leading: Image.asset(
                                      "assets/images/store.png",
                                      width: 35,
                                    ),
                                    label: 'Suivie paiement',
                                    color: Colors.teal,
                                  ),
                                  ServiceCard(
                                    onTap: () {
                                      // Get.toNamed(Routes.CLINIQUE);
                                    },
                                    leading: Image.asset(
                                      "assets/images/store.png",
                                      width: 35,
                                    ),
                                    label: 'Nos statistiques',
                                    color: Colors.blue,
                                  ),
                                  ServiceCard(
                                    onTap: () {
                                      // Get.toNamed(AppPages.RAPPELMEDI);
                                    },
                                    leading: Icon(
                                      Icons.access_alarm,
                                      color: Colors.purple.shade500,
                                    ),
                                    label: 'Support contact',
                                    color: Colors.purple.shade500,
                                  ),
                                ],
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
            EditProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
