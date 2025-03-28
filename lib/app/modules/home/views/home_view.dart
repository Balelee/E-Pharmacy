import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/modules/home/views/basket_view.dart';
import 'package:e_pharma/app/modules/home/views/bien_etre_view.dart';
import 'package:e_pharma/app/modules/home/views/dashboard_view.dart';
import 'package:e_pharma/app/modules/home/views/product_list_view.dart';
import 'package:e_pharma/app/modules/home/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: NavigationController.to.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) =>
            NavigationController.to.currentIndex.value = index,
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return DashboardView();
            case 1:
              return BienEtreView();
            case 2:
              return Container(color: Colors.green);
            case 3:
              return BasketView();
            case 4:
              return ProfileView();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
