import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:e_pharma/app/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BasketView extends GetView<ProductController> {
  const BasketView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Détail du panier",
            style: AppTextStyles.heading4,
            overflow: TextOverflow.visible,
          ),
          centerTitle: false,
          actions: [
            controller.panierList.isNotEmpty
                ? CustomButton.primaryButton(
                    onPressed: () {
                      controller.payeForProducts();
                    },
                    buttonTitle: "Payer maintenant",
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Get.theme.cardColor,
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: 8,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                  )
                : SizedBox.shrink(),
          ],
        ),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16, horizontal: SizeConstant.haurizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  decoration: BoxDecoration(
                      color: Get.theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(26.0)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.theme.scaffoldBackgroundColor,
                      foregroundColor: Get.theme.primaryColor,
                      child: Icon(Icons.location_on),
                    ),
                    title: CustomText(text: "Address de livraison"),
                    subtitle: CustomText(
                      text: controller.deliveryAdress.value,
                      style: AppTextStyles.caption,
                    ),
                    trailing: CustomButton.secondaryButton(
                      onPressed: () {},
                      buttonTitle: "Editer",
                      mainAxisSize: MainAxisSize.min,
                      padding: EdgeInsets.all(0.0),
                      textStyle: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  child: CustomText(
                      text: "${controller.panierList.length} produits"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.panierList.length,
                    itemBuilder: (context, index) {
                      var cartItem = controller.panierList[index];
                      var product = cartItem.product;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              color: Get.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(26.0)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width: context.width / 4,
                                  height: context.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: product.imageUrl != null &&
                                            product.imageUrl!.isNotEmpty
                                        ? Image.network(
                                            product.imageUrl!,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(Icons.broken_image,
                                                    size: 50),
                                          )
                                        : const Icon(Icons.broken_image,
                                            size: 50),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: product.name,
                                      style: AppTextStyles.bodyText2,
                                    ),
                                    CustomText(
                                      text: "Disponible",
                                      style: AppTextStyles.caption,
                                    ),
                                    CustomText(
                                      text:
                                          "${product.price} x ${cartItem.quantity}",
                                      style: AppTextStyles.bodyText1Bold,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    alignment: Alignment.centerRight,
                                    onPressed: () =>
                                        controller.removeFromCart(product.id),
                                    icon: Icon(Icons.delete,
                                        size: 20, color: AppColors.error),
                                  ),
                                  QuantitySelector(productId: product.id),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomText(
                          text: "Recap de la commande",
                          style: AppTextStyles.bodyText1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildRow("Command",
                                "${controller.totalCommande.toInt()}F"),
                            _buildRow("Frais de livraison",
                                "${controller.fraisLivraison.toInt()}F"),
                            Divider(),
                            _buildRow(
                                "Total", "${controller.totalPrice.toInt()}F",
                                isBold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fonction pour afficher une ligne
  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            style: isBold
                ? AppTextStyles.bodyText1PrimaryBold
                : AppTextStyles.bodyText2,
          ),
          CustomText(
            text: value,
            style: isBold
                ? AppTextStyles.bodyText1PrimaryBold
                : AppTextStyles.bodyText2,
          ),
        ],
      ),
    );
  }
}
