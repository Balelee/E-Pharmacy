import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/auxiliaire_order.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/bottomSheet_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

class OrderAuxiliaireItemWidget extends StatelessWidget {
  final AuxiliaireOrder order;
  const OrderAuxiliaireItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isBottomSheetOpen == false) {
          BottomsheetHelper.commandeDetailBottomSheet(order: order);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Commande #${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: order.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: order.statusLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: order.statusColor,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Client : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text:order.clientPhone,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Montant total : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: "${order.amount.toString()} CFA",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomButton.primaryButton(
                    height: 30,
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    onPressed: () {
                      if (Get.isBottomSheetOpen == false) {
                        BottomsheetHelper.commandeDetailBottomSheet(
                            order: order);
                      }
                    },
                    buttonTitle: "Traiter",
                    backgroundColor: AppColors.success)
              ],
            ),
          ),
        ),
      ),
    );

   
  }
}
