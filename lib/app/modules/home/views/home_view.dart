import 'package:e_pharma/app/composants/app_colors.dart';
import 'package:e_pharma/app/composants/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                    color: const Color(0xFF28722B),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    )),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'images/splashImage.jpg',
                    fit: BoxFit.contain,
                    width: Get.width * 0.6,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              const Text(
                'E-pharmacie',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Trouvez et commandez vos médicaments en toute sécurité depuis chez vous, en quelques clics !",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              right: 15,
              left: 15,
            ),
            child: MainButton.mainButton(
              onPressed: () {
                // ignore: avoid_print
                print("Suivant");
              },
              buttonTile: 'Suivant',
              textColor: Colors.white,
              trailingIcon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
