import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharmix/app/data/repositories/user_repository.dart';
import 'package:pharmix/app/modules/client/home/controllers/profile_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/validators.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import 'package:pharmix/app/widgets/loding_indicator.dart';
import 'package:pharmix/generated/locales.g.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(
          () => SafeArea(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade300,
                                child: Image.asset(
                                  "assets/images/user.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            controller.userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.userEmail.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Form(
                      key: controller.updateProfileFormkey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: controller.lastNameController,
                            labelText: LocaleKeys.nom.tr,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.person),
                            validator: (p0) {
                              final error = Validators.validateSimpleText(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: controller.firstNameController,
                            labelText: LocaleKeys.prenom.tr,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.person),
                            validator: (p0) {
                              final error = Validators.validateSimpleText(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: controller.placeOfBirthController,
                            labelText: LocaleKeys.place_date.tr,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.place),
                            validator: (p0) {
                              final error = Validators.validateSimpleText(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: controller.dateOfBirthController,
                            labelText: LocaleKeys.birth_date.tr,
                            keyboardType: TextInputType.datetime,
                            inputFormatters: [
                              MaskTextInputFormatter(mask: '##-##-####')
                            ],
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.calendar_today),
                            validator: (p0) {
                              final error = Validators.validateSimpleText(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: controller.phoneController,
                            labelText: LocaleKeys.phone.tr,
                            keyboardType: TextInputType.phone,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.phone),
                            validator: (p0) {
                              final error = Validators.validatePhoneNumber(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: controller.emailController,
                            labelText: LocaleKeys.Email.tr,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            prefix: Icon(Icons.email),
                            validator: (p0) {
                              final error = Validators.validateEmail(p0);
                              return error;
                            },
                            onChanged: (Value) => controller.setIsEditting(),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    if (controller.isEditting.value)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton.secondaryButton(
                              onPressed: () => controller.cancelEditting(),
                              padding: EdgeInsets.all(0.0),
                              buttonTitle: LocaleKeys.cancel.tr,
                              textColor: AppColors.error,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton.primaryButton(
                              onPressed: () {
                                controller.updateData();
                              },
                              elevation: 0.0,
                              borderRadius: 6,
                              height: 35,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.1),
                              textColor: AppColors.primary,
                              padding: EdgeInsets.all(0.0),
                              fontSize: 14.0,
                              buttonTitle: 'Enregistrer',
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.lazyPut(() => UserRepository());
                          controller.logOut();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.canvasColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
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
                                      color: Get.theme.primaryColor,
                                    )
                                  : null,
                            ),
                          ),
                        ),
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
