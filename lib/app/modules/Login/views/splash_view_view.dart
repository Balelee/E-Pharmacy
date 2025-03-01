import 'package:e_pharma/app/modules/Login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashViewView extends GetView<LoginController> {
  const SplashViewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Stack(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'E-pharmacie',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: context.height / 5,
                    right: 10.0,
                    left: 10.0,
                    top: 10.0),
                child: Text(
                  "Trouvez et commandez vos médicaments en toute sécurité depuis chez vous, en quelques clics !",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(221, 104, 104, 104),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
