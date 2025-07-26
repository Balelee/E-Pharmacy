import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: CustomText(
                text: "Ajoutez votre addresse de livraison",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomText(
                text: "Nom complet",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            CustomTextFormField(
              hintText: "Ex: Ayamard Luc",
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomText(
                text: "Numéro de téléphone",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            CustomTextFormField(
              hintText: "Ex: 67 45 23 12",
              hintStyle: TextStyle(color: Colors.grey[400]),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: CustomText(
                        text: "Ville",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 2.3,
                      child: CustomTextFormField(
                        hintText: "Ex:Ouagadougou",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: CustomText(
                        text: "Quartier",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 2.3,
                      child: CustomTextFormField(
                        hintText: "Ex:Ouaga 2000",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomText(
                text: "Complément d'adresse",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            CustomTextFormField(
              hintText: "Ex: Immeuble XYZ, Porte 3B",
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            const SizedBox(height: 20),
            CustomButton.primaryButton(
              onPressed: () {},
              buttonTitle: "Ajouter votre addresse",
              textStyle: TextStyle(
                fontSize: 14,
                color: Get.theme.cardColor,
                fontWeight: FontWeight.bold,
              ),
              borderRadius: 8,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ],
        ),
      ),
    );
  }
}
