import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:e_pharma/app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EditpageView extends GetView {
  const EditpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: AppColors.textSecondary,
            )),
        width: Get.width,
        height: Get.height / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Mettre a jour votre cycle",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
              hintText: "28-06-2025 à 28-07-2025",
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
              ),
              prefix: Icon(
                Icons.calendar_today,
                color: AppColors.textSecondary,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.primary)),
            ),
            SizedBox(
              height: 25,
            ),
            CustomButton.primaryButton(
                onPressed: () {}, buttonTitle: "Enregistrer vos dates")
          ],
        ),
      ),
    );
  }
}
