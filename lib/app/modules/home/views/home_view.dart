import 'package:e_pharma/app/cummon/controllers/navigation_controller.dart';
import 'package:e_pharma/app/modules/Login/views/login_view.dart';
import 'package:e_pharma/app/modules/Register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cummon/controllers/base_controller.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Bottom Bar'),
        centerTitle: true,
      ),
      body: PageView(
        controller: NavigationController.to.pageController,
        onPageChanged: (index) =>
            NavigationController.to.currentIndex.value = index,
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: const Color.fromARGB(255, 243, 152, 33),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
