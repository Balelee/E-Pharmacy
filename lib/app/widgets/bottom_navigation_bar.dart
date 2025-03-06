import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ConvexAppBar(
        backgroundColor: AppColors.background,
        color: Colors.grey,
        activeColor: Get.theme.primaryColor,
        style: TabStyle.reactCircle,
        initialActiveIndex: NavigationController.to.currentIndex.value,
        onTap: (index) {
          NavigationController.to.changePage(index);
          NavigationController.to.pageController.jumpToPage(index);
        },
        items: [
          TabItem(icon: Icons.home, title: "Acceuil"),
          TabItem(icon: Icons.health_and_safety, title: "Bien être"),
          TabItem(icon: Icons.forum, title: "Forum"),
          TabItem(icon: Icons.shopping_cart, title: "Cart"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
      );
    });
  }
}


// NavigationBar(
//         indicatorColor: Theme.of(context).primaryColor,
//         elevation: 10,
//         selectedIndex: currentIndex,
//         onDestinationSelected: (index) =>
//             NavigationController.to.changePage(index),
//         destinations: [
//           NavigationDestination(
//             icon: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 300),
//               transitionBuilder: (child, animation) {
//                 return ScaleTransition(scale: animation, child: child);
//               },
//               child: currentIndex == 0
//                   ? const Icon(Icons.home, key: ValueKey('selectedHome'))
//                   : const Icon(Icons.home_outlined,
//                       key: ValueKey('unselectedHome')),
//             ),
//             label: "Home",
//           ),
//           NavigationDestination(
//             icon: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 300),
//               transitionBuilder: (child, animation) {
//                 return ScaleTransition(scale: animation, child: child);
//               },
//               child: currentIndex == 1
//                   ? const Icon(Icons.person_2, key: ValueKey('selectedProfile'))
//                   : const Icon(Icons.person_2_outlined,
//                       key: ValueKey('unselectedProfile')),
//             ),
//             label: "Profile",
//           ),
//         ],
//       );