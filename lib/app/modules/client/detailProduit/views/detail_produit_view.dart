import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/data/models/product.dart';
import 'package:pharmix/app/modules/client/home/controllers/product_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/size_constant.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

class DetailProduitView extends GetView<ProductController> {
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
                    "assets/images/productimg.png",
                    fit: BoxFit.cover,
                  ),
                ),
                CustomText(
                  text: produit.name,
                  style: AppTextStyles.heading4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomText(
                    text: produit.description ?? '',
                    style: AppTextStyles.bodyText1,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: () {
                  controller.addToCart(produit);
                  Get.back();
                },
                buttonTitle: "Ajouter au panier",
                textStyle: TextStyle(fontSize: 12, color: AppColors.secondary))
          ],
        ),
      ],
    );
  }
}
