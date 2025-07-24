import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/profile_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/loding_indicator.dart';
import 'package:pharmix/generated/locales.g.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
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
                  const SizedBox(height: 24),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                      label: 'Nom complet', value: controller.userName),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                            label: 'Lieu de naissance',
                            value: controller.userbirtplace),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: 'Date de naissance',
                          value: controller.userbirthday,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Téléphone', value: controller.userPhone),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Email', value: controller.userEmail),
                  const SizedBox(height: 24),
                  CustomButton.primaryButton(
                    onPressed: () {},
                    buttonTitle: 'Enregistrer',
                  ),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
