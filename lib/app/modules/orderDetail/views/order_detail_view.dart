import 'package:e_pharma/app/data/models/order.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/app_constant.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  OrderDetailView({super.key});
  Order order = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.order.value = order;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Detail de la commande",
          style: AppTextStyles.heading4,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.haurizontalPadding),
        child: Column(
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
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Row(
                children: [
                  CustomText(text: "${order.orderDetails.length} produits"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderDetails.length,
                itemBuilder: (context, index) {
                  var orderItem = order.orderDetails[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
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
                                child: orderItem.imageUrl != null &&
                                        orderItem.imageUrl!.isNotEmpty
                                    ? Image.network(
                                        orderItem.imageUrl!,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image,
                                                    size: 50),
                                      )
                                    : const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: orderItem.productName,
                                  style: AppTextStyles.bodyText2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: CustomText(
                                    text:
                                        "${orderItem.priceUnitaire} x ${orderItem.quantity}",
                                    style: AppTextStyles.bodyText1Bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: orderItem.status,
                                style: AppTextStyles.bodyText1PrimaryBold
                                    .copyWith(color: orderItem.statusColor),
                              ),
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
                        _buildRow(
                            "Command", "${controller.totalCommande.toInt()}F"),
                        _buildRow("Frais de livraison",
                            "${controller.fraisLivraison.toInt()}F"),
                        Divider(),
                        _buildRow("Total", "${controller.totalPrice.toInt()}F",
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
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                      text: "Prix total", style: AppTextStyles.bodyText1),
                  CustomText(
                      text: "${controller.totalPrice.toInt()}F",
                      style: AppTextStyles.bodyText1PrimaryBold),
                ],
              ),
              CustomButton.primaryButton(
                onPressed: () {},
                buttonTitle: "Payer maintenant",
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Get.theme.cardColor,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: 8,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
              ),
            ],
          ),
        )
      ],
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
