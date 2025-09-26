import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/enums/order_status_enum.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/pharmacien/order_auxiliaire_item_widget.dart';
import 'package:pharmix/app/widgets/pharmacien/unwaitingOrders_auxiliaire_item_widget.dart';
import 'package:pharmix/generated/locales.g.dart';

class OrderAuxiliaireListWidget extends GetView<PharmacienController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: controller.orders.isEmpty
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.selectedOrderStatus.value ==
                  OrderPharmacyStatusEnum.traite ||
              controller.selectedOrderStatus.value ==
                  OrderPharmacyStatusEnum.refused) {
            if (controller.unwaitingsOrders.isEmpty) {
              return SizedBox(
                height: context.height / 1.7,
                child: Center(
                  child: CustomText(
                    text:
                        "${LocaleKeys.no_data.tr} ${controller.selectedOrderStatus.value.label}",
                    style: AppTextStyles.caption,
                  ),
                ),
              );
            }
            return UnwaitingordersAuxiliaireItemWidget(
              unwaitingorders: controller.unwaitingsOrders.value,
              onValidate: (p0) {},
            );
          }
          if (controller.orders.isEmpty) {
            return SizedBox(
              height: context.height / 1.7,
              child: Center(
                child: CustomText(
                  text: LocaleKeys.no_data_available.tr,
                  style: AppTextStyles.caption,
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) => OrderAuxiliaireItemWidget(
              order: controller.orders[index],
              onValidate: (p0) {
                controller.storeOrderResponse(
                    orderId: controller.orders[index].id, data: {'items': p0});
              },
            ),
          );
        })
      ],
    );
  }
}
