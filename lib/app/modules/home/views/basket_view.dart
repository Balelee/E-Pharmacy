import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/cart_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/size_constant.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/order_card.dart';
import 'package:pharmix/app/widgets/quantity_selector.dart';

class BasketView extends GetView<CartController> {
  const BasketView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Détail du panier",
          style: AppTextStyles.heading4,
          overflow: TextOverflow.visible,
        ),
        centerTitle: false,
        actions: [],
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.0, horizontal: SizeConstant.haurizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child:
                    CustomText(text: "${controller.orders.length} commandes"),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.orders
                      .map((order) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () => Get.toNamed(AppPages.ORDER_DETAIL,
                                  arguments: order),
                              child: OrderCard(order: order),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
              controller.panierList.isNotEmpty
                  ? CustomButton.primaryButton(
                      onPressed: () {
                        controller.storeCommand();
                      },
                      buttonTitle: "Demander la disponibilité",
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
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0))
            ],
          ),
        ),
      ),
    );
  }
}
