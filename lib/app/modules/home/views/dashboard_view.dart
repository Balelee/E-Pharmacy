import 'package:e_pharma/app/modules/home/views/product_list_view.dart';
import 'package:e_pharma/app/widgets/service_card.dart';
import 'package:e_pharma/app/widgets/tip_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardView extends GetView {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '👋 Welcome',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF202938),
                        ),
                      ),
                      Text(
                        'Alice Marie',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                        child:
                            const Icon(Icons.notifications_outlined, size: 20),
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
                          child: const Text(
                            textAlign: TextAlign.center,
                            '3',
                            style: TextStyle(
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
                          const Text(
                            'Nos services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202938),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.count(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.14,
                            children: [
                              ServiceCard(
                                onTap: () {
                                  Get.to(() => ProductListView());
                                },
                                icon: Icons.shopping_bag,
                                label: 'Marketplace',
                                color: Colors.blue,
                              ),
                              ServiceCard(
                                onTap: () {},
                                icon: Icons.calendar_today,
                                label: 'Cycle',
                                color: Colors.pink,
                              ),
                              ServiceCard(
                                onTap: () {},
                                icon: Icons.pregnant_woman,
                                label: 'Grossesse',
                                color: Colors.purple,
                              ),
                              ServiceCard(
                                onTap: () {},
                                icon: Icons.child_care,
                                label: 'Bébé',
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
                          const Text(
                            'Conseils du Jour',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202938),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TipCard(
                            onTap: () {},
                            icon: Icons.favorite,
                            title: 'Bien-être pendant la grossesse',
                            description:
                                'Conseils pour rester en bonne santé pendant votre grossesse...',
                            color: Colors.pink,
                          ),
                          const SizedBox(height: 16),
                          TipCard(
                            onTap: () {},
                            icon: Icons.nightlight,
                            title: 'Sommeil de bébé',
                            description:
                                'Astuces pour améliorer le sommeil de votre bébé...',
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
    );
  }
}
