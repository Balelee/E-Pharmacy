import 'package:e_pharma/app/data/models/product.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_produit_controller.dart';

class DetailProduitView extends GetView<DetailProduitController> {
  DetailProduitView({super.key});
  final Product produit = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: CustomText(
          text: "Détail du produit",
          style: AppTextStyles.heading3,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16, horizontal: SizeConstant.haurizontalPadding),
        child: SingleChildScrollView(
          child: Container(
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    produit.imageUrl ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                CustomText(
                  text: produit.name,
                  style: AppTextStyles.heading4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomText(
                    text: " Stock: ${produit.stock}",
                    style: AppTextStyles.bodyText1Hight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomText(
                    text: produit.description,
                    style: AppTextStyles.bodyText1,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: context.height / 12,
        decoration: BoxDecoration(color: AppColors.background),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Prix",
                    style: AppTextStyles.bodyText1,
                    overflow: TextOverflow.visible,
                  ),
                  CustomText(
                    text: "${produit.price} F",
                    style: AppTextStyles.bodyText1Bold,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
              CustomButton.primaryButton(
                  leadingIcon: Icon(Icons.shopping_cart_outlined,
                      color: AppColors.secondary),
                  onPressed: () {},
                  buttonTitle: "Ajouter au panier",
                  textStyle:
                      TextStyle(fontSize: 12, color: AppColors.secondary))
            ],
          ),
        ),
      ),
    );
  }
}
