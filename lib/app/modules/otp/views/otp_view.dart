import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:e_pharma/app/widgets/otp_field_widget.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(vertical: 16, horizontal: SizeConstant.haurizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "OTP vérification ",
                        style: AppTextStyles.heading1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Entrez l’OTP envoyé à",
                            style: AppTextStyles.bodyText3,
                            textAlign: TextAlign.right,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              text: "+225 03 37 23 4758",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: OTPFieldWidget(
                    onCompleted: (value) {},
                    otpController: controller.otpController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Vous n’avez pas Reçu l’OTP?",
                        style: AppTextStyles.bodyText3,
                        textAlign: TextAlign.right,
                      ),
                      CustomButton.secondaryButton(
                        buttonTitle: "Renvoyé l’OPT",
                        onPressed: () {
                          Get.toNamed(AppPages.LOGINCONTENT);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomButton.primaryButton(
                      onPressed: () {
                        Get.offAllNamed(AppPages.HOME);
                      },
                      buttonTitle: LocaleKeys.buttons_continuous.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
