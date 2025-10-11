import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/loding_indicator.dart';
import 'package:pharmix/generated/locales.g.dart';

class AuxiliaireHeaderWidget extends GetView<PharmacienController> {
  const AuxiliaireHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 7,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  "${LocaleKeys.welcome.tr} ${LocaleKeys.final_welcome_title.tr}",
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xFF202938))),
              Text(
                "${controller.user.user?.pharmacie?.name}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF202938),
                    ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.lazyPut(() => UserRepository());
                  controller.logOut();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Obx(
                    () => controller.isLoding.value
                        ? LoadingIndicator(
                            color: Get.theme.primaryColor,
                          )
                        : Icon(
                            Icons.logout,
                            color: Colors.black54,
                          ),
                  ),
                ),
              ),
              Obx(() => Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0x1A202938)),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child:
                            const Icon(Icons.notifications_outlined, size: 20),
                      ),
                      if (controller.notificationCount.value > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              controller.notificationCount.value.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
