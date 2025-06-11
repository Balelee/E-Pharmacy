import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final nav = NavigationController.to;
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Bien-être',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Vous',
          ),
        ],
        onTap: (index) {
          nav.pageController.jumpToPage(index);
        },
        currentIndex: nav.currentIndex.value,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xFF202938),
      );
    });
  }
}
