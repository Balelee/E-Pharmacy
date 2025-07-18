import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import '../controllers/paiement_controller.dart';

class PaiementView extends GetView<PaiementController> {
  const PaiementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Selectionner mehode de paiement',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  cardMethode(
                    imagePath: "assets/images/orange.jpg",
                    title: "OrangeMoney",
                    isActive: controller.selectedMethod.value == "OrangeMoney",
                    onTap: () => controller.selectMethod("OrangeMoney"),
                  ),
                  SizedBox(width: 8),
                  cardMethode(
                    imagePath: "assets/images/moov.png",
                    title: "MoovMoney",
                    isActive: controller.selectedMethod.value == "MoovMoney",
                    onTap: () => controller.selectMethod("MoovMoney"),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  text: 'Composé ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: controller.codeUSSD.toString(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' pour recevoir le code OTP',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CustomText(
                  text: "Numéro de téléphone",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              CustomTextFormField(
                hintText: "Ex: 57 56 34 23",
                hintStyle: TextStyle(color: Colors.grey[400]),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CustomText(
                  text: "Code OTP",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              CustomTextFormField(
                hintText: "Ex:098945",
                hintStyle: TextStyle(color: Colors.grey[400]),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton.primaryButton(
                onPressed: () {},
                buttonTitle: "Finaliser paiement",
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Get.theme.cardColor,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: 8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardMethode({
  required String imagePath,
  required String title,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(10),
      width: Get.width / 2.5,
      height: 80,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: isActive ? 2 : 1,
          color: isActive ? Colors.orange : Colors.black12,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 40),
          SizedBox(height: 5),
          CustomText(
            text: title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}
