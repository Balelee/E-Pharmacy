import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/auth_message.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/utils/constants/size_constant.dart';
import 'package:pharmix/app/utils/validators.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/otp_field_widget.dart';
import 'package:pharmix/generated/locales.g.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/otp_controller.dart';

// ignore: must_be_immutable
class OtpView extends GetView<OtpController> {
  OtpView({super.key});
  AuthMessage? authMessage = Get.arguments;
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
                              text: authMessage?.phone ?? "",
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
                  child: Form(
                    key: controller.otpFormkey,
                    child: OTPFieldWidget(
                      onCompleted: (value) {},
                      otpController: controller.otpController,
                      length: AppConstant.otpLength,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        return Validators.validateOTP(value);
                      },
                    ),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomButton.primaryButton(
                      onPressed: () {
                        // controller.verifyOtp(phone: authMessage?.phone);
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
