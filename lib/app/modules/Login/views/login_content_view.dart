import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/Login/controllers/login_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/validators.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_icon.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import '../../../../generated/locales.g.dart';
import '../../../themes/app_text_styles.dart';
import '../../../widgets/custom_text.dart';

class LoginContentView extends GetView<LoginController> {
  const LoginContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 0),
                    child: Image.asset(
                      'assets/images/sflogo.png',
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: LocaleKeys.login.tr,
                          style: AppTextStyles.heading3,
                        ),
                        CustomText(
                          text: LocaleKeys.login_description.tr,
                          style: AppTextStyles.bodyText3,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: controller.loginFormkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: SizedBox(
                            height: 50,
                            child: CustomTextFormField(
                              controller: controller.emailphoneController,
                              labelText: "Email ou Téléphone",
                              prefix: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: SizedBox(
                            height: 50,
                            child: CustomTextFormField(
                              controller: controller.passwordController,                              labelText: LocaleKeys.password.tr,
                              prefix: Icon(Icons.lock),
                              obscureText: controller.isPasswordHidden.value,
                              suffix: IconButton(
                                icon: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              validator: (value) {
                                return Validators.validatePassword(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: LocaleKeys.forgot_password.tr,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomButton.primaryButton(
                        onPressed: () {
                          // Get.toNamed(AppPages.OTP);
                          controller.login();
                        },
                        buttonTitle: LocaleKeys.login.tr),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: CustomText(
                        text: LocaleKeys.or_continue_with.tr.toUpperCase(),
                        style: AppTextStyles.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton.primaryButton(
                          onPressed: () {},
                          buttonTitle: "",
                          backgroundColor: AppColors.secondary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 14.0),
                          elevation: 0.0,
                          child: CustomIcon.socialMedia(
                              localPath: 'assets/images/google.svg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomButton.primaryButton(
                            onPressed: () {},
                            buttonTitle: "",
                            backgroundColor: AppColors.secondary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 14.0),
                            elevation: 0.0,
                            child: CustomIcon.socialMedia(
                                localPath: 'assets/images/apple.svg'),
                          ),
                        ),
                        CustomButton.primaryButton(
                          onPressed: () {},
                          buttonTitle: "",
                          backgroundColor: AppColors.secondary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 14.0),
                          elevation: 0.0,
                          child: CustomIcon.socialMedia(
                              localPath: 'assets/images/facebook.svg'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: LocaleKeys.no_account.tr,
                          style: AppTextStyles.bodyText3,
                          textAlign: TextAlign.right,
                        ),
                        CustomButton.secondaryButton(
                          buttonTitle: LocaleKeys.sign_up.tr,
                          onPressed: () {
                            Get.offAllNamed(AppPages.REGISTER);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
