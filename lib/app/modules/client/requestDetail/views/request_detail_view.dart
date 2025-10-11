import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/modules/client/address/views/address_view.dart';
import 'package:pharmix/app/modules/client/paiement/views/paiement_view.dart';
import 'package:pharmix/app/modules/client/requestDetail/controllers/request_detail_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

// ignore: must_be_immutable
class RequestDetailView extends GetView<RequestDetailController> {
  RequestDetailView({super.key});
  Request request = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.request.value = request;
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
                trailing: request.status == "enattente"
                    ? SizedBox.shrink()
                    : CustomButton.secondaryButton(
                        onPressed: () {
                          Get.bottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            backgroundColor: AppColors.background,
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: AddressView(),
                            ),
                          );
                        },
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
                  CustomText(text: "${request.requestDetails.length} produits"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: request.requestDetails.length,
                itemBuilder: (context, index) {
                  var requestItem = request.requestDetails[index];

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
                                child: Image.asset(
                                  "assets/images/productimg.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: requestItem.productName ?? "",
                                  style: AppTextStyles.bodyText2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: CustomText(
                                    text:
                                        "${requestItem.priceUnitaire} x ${requestItem.quantity}",
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
                                text: requestItem.statusLabel ?? "",
                                style: AppTextStyles.bodyText1PrimaryBold
                                    .copyWith(color: requestItem.statusColor),
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
              request.status == "enattente"
                  ? SizedBox.shrink()
                  : CustomButton.primaryButton(
                      onPressed: () {
                        Get.bottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          backgroundColor: AppColors.background,
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: PaiementView(),
                          ),
                        );
                      },
                      buttonTitle: "Payer maintenant",
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Get.theme.cardColor,
                        fontWeight: FontWeight.bold,
                      ),
                      borderRadius: 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0.0),
                    )
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
