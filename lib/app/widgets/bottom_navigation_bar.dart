import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final nav = NavigationController.to;
      return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.background,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Vous',
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
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color(0xFF202938),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      );
    });
  }
}
