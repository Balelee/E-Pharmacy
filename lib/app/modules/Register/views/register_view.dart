import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/utils/validators.dart';
import 'package:e_pharma/app/widgets/country_code_box.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:e_pharma/app/widgets/custom_icon.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:e_pharma/app/widgets/custom_text_form_field.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

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
                vertical: 16, horizontal: SizeConstant.haurizontalPadding),
            child: Obx(
              () => SizedBox(
                width: context.width,
                // height: context.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: CustomText(
                          text: LocaleKeys.continue_with.tr.toUpperCase(),
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: CustomText(
                          text:
                              LocaleKeys.or_with_phone_number.tr.toUpperCase(),
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
                            child: CustomTextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controller.phoneController,
                              labelText: LocaleKeys.phone.tr,
                              prefix: contryCodeBox(
                                  selectedCode: controller.contryCode),
                              validator: (value) {
                                return Validators.validatePhoneNumber(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              validator: (value) {
                                return Validators.validatePassword(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CustomTextFormField(
                              controller: controller.confirmPasswordController,
                              labelText: LocaleKeys.confirmPassword.tr,
                              prefix: Icon(Icons.lock),
                              obscureText:
                                  controller.isConfirmPasswordHidden.value,
                              suffix: IconButton(
                                icon: Icon(
                                  controller.isConfirmPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                              ),
                              validator: (value) {
                                return Validators.validateConfirmPassword(
                                    value: value,
                                    passwordController:
                                        controller.passwordController);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CustomButton.primaryButton(
                          onPressed: () => controller.signUp(),
                          buttonTitle: LocaleKeys.buttons_continuous.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
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
                      ),
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
