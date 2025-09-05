import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/views/order_auxiliaire_view.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import '../controllers/pharmacien_controller.dart';

class PharmacienView extends GetView<PharmacienController> {
  const PharmacienView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: NavigationController.to.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          NavigationController.to.currentIndex.value = index;
        },
        children: [
          OrderAuxiliaireView(),
          Center(child: Text("Historique")),
          Center(child: Text("Paiement")),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final nav = NavigationController.to;
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.background,
            items: [
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart),
                    Positioned(
                      right: -6,
                      top: -3,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: CustomText(
                          text: controller.orders.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                label: 'Commande',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Historique",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "Paiement",
              ),
            ],
            onTap: (index) {
              nav.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
              nav.currentIndex.value = index;
            },
            currentIndex: nav.currentIndex.value,
            selectedItemColor: AppColors.success,
            unselectedItemColor: const Color(0xFF202938),
            type: BottomNavigationBarType.fixed,
            elevation: 8,
          ),
        );
      }),
    );
  }
}
