import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/profile_controller.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/loding_indicator.dart';
import 'package:pharmix/app/widgets/profil_widgets.dart';
import 'package:pharmix/generated/locales.g.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            ProfileHeader(
              userAvatar: controller.userAvatar,
            ),
            Container(
              height: context.height * 0.05,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.haurizontalPadding),
                controller: ScrollController(),
                children: [
                  ProfileDetails(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: GestureDetector(
                      onTap: () => controller.logOut(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          color: Get.theme.canvasColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Obx(
                          () => ListTile(
                            leading: const Icon(Icons.logout),
                            title: CustomText(
                              text: LocaleKeys.buttons_logout.tr,
                              style: AppTextStyles.bodyText1,
                            ),
                            trailing: controller.isLoding.value
                                ? LoadingIndicator(
                                    color: Get.theme.primaryColor)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
