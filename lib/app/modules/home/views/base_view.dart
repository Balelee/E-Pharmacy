import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/modules/home/views/dashboard_view.dart';
import 'package:pharmix/app/modules/home/views/profile_view.dart';
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
          EditProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
