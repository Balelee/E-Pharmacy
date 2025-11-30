// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/cart_item.dart';
import 'package:pharmix/app/modules/client/home/views/basket_view.dart';
import 'package:pharmix/app/utils/helpers/bottomSheet_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';

class Functions {
  static void displayBasketBottomSheet({
    required VoidCallback? onValidate,
    required RxString errorValue,
    required RxList<CartItem> panierList,
    VoidCallback? onCancel,
  }) async {
    final theme = Get.theme;
    await BottomsheetHelper.displayBottomSheet(
      title: "Details de requette",
      content: [
        const BasketView(),
      ],
      action: Obx(() => panierList.isNotEmpty
          ? Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 35),
                      child: CustomButton.primaryButton(
                        onPressed: onValidate,
                        buttonTitle: "Demander la disponibilité",
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Get.theme.cardColor,
                          fontWeight: FontWeight.bold,
                        ),
                        borderRadius: 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                      )),
                ),
              ],
            )
          : SizedBox.shrink()),
    ).then((widget) => widget);
    return null;
  }
}
