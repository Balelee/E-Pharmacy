import 'package:e_pharma/app/modules/Login/controllers/login_controller.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashViewView extends GetView<LoginController> {
  const SplashViewView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                    color: AppColors.primary,
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
                    'assets/images/splashImage.jpg',
                    fit: BoxFit.contain,
                    width: Get.width * 0.6,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_name.tr,
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
                    LocaleKeys.slogan.tr,
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
      ),
    );
  }
}
