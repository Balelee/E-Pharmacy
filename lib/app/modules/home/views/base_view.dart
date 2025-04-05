import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/modules/home/views/bien_etre_view.dart';
import 'package:e_pharma/app/modules/home/views/dashboard_view.dart';
import 'package:e_pharma/app/modules/home/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../controllers/home_controller.dart';

class BaseView extends GetView<HomeController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: NavigationController.to.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          NavigationController.to.currentIndex.value = index;
        },
        children: const [
          DashboardView(),
          BienEtreView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
