import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/quantity_selector.dart';

class BasketView extends GetView<CartController> {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 🔥 permet l'intégration dans le bottomSheet proprement
      height: Get.height * 0.75,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nombre d'éléments
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child:
                  CustomText(text: "${controller.panierList.length} produits"),
            ),

            /// 🟢 La liste scrollable correctement !
            Expanded(
              child: ListView.builder(
                itemCount: controller.panierList.length,
                itemBuilder: (context, index) {
                  var cartItem = controller.panierList[index];
                  var product = cartItem.product;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      child: Row(
                        children: [
                          /// Image
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

                          /// Infos du produit
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: product.name,
                                    style: AppTextStyles.bodyText2),
                                CustomText(
                                    text: "Disponible",
                                    style: AppTextStyles.caption),
                                CustomText(
                                  text:
                                      "${product.price} x ${cartItem.quantity}",
                                  style: AppTextStyles.bodyText1Bold,
                                ),
                              ],
                            ),
                          ),

                          /// Actions
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    controller.removeFromCart(product.id!),
                                icon: Icon(Icons.delete,
                                    size: 20, color: AppColors.error),
                              ),
                              QuantitySelector(productId: product.id!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
