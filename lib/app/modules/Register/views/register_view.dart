import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/size_constant.dart';
import 'package:pharmix/app/utils/validators.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_icon.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import 'package:pharmix/generated/locales.g.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: SizeConstant.haurizontalPadding),
            child: Obx(
              () => SizedBox(
                width: context.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: LocaleKeys.free_sign_up.tr,
                            style: AppTextStyles.heading3,
                          ),
                          CustomText(
                            text: LocaleKeys.login_description.tr,
                            style: AppTextStyles.bodyText3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: LocaleKeys.continue_with.tr.toUpperCase(),
                        style: AppTextStyles.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: CustomText(
                          text: "OU AVEC VOS INFORTIONS PERSONNELLES",
                          style: AppTextStyles.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Form(
                      key: controller.signUpFormkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: CustomTextFormField(
                                labelText: "Nom d'utilisateur",
                                controller: controller.usernameController,
                                prefix: Icon(Icons.person),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / 2.2,
                                  height: 50,
                                  child: CustomTextFormField(
                                    labelText: "Nom",
                                    controller: controller.lastnameController,
                                    prefix: Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 2.2,
                                  height: 50,
                                  child: CustomTextFormField(
                                    labelText: "Prénom(s)",
                                    controller: controller.firstnameController,
                                    prefix: Icon(Icons.person),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: CustomTextFormField(
                                labelText: "Email",
                                controller: controller.emailController,
                                prefix: Icon(Icons.email),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: CustomTextFormField(
                                labelText: "Téléphone",
                                controller: controller.phoneController,
                                prefix: Icon(Icons.phone),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / 2.2,
                                  height: 50,
                                  child: CustomTextFormField(
                                    labelText: "Date naissance",
                                    controller: controller.birthdateController,
                                    prefix: Icon(Icons.calendar_month),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 2.2,
                                  height: 50,
                                  child: CustomTextFormField(
                                    labelText: "Lieu naissance",
                                    controller: controller.birthplaceController,
                                    prefix: Icon(Icons.place),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: CustomTextFormField(
                                controller: controller.passwordController,
                                labelText: LocaleKeys.password.tr,
                                prefix: Icon(Icons.lock),
                                obscureText: controller.isPasswordHidden.value,
                                suffix: IconButton(
                                  icon: Icon(
                                    controller.isPasswordHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
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
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: CustomButton.primaryButton(
                          onPressed: () => controller.signUp(),
                          buttonTitle: LocaleKeys.buttons_continuous.tr),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: LocaleKeys.have_account.tr,
                          style: AppTextStyles.bodyText3,
                          textAlign: TextAlign.right,
                        ),
                        CustomButton.secondaryButton(
                          buttonTitle: LocaleKeys.login.tr,
                          onPressed: () {
                            Get.toNamed(AppPages.LOGINCONTENT);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
