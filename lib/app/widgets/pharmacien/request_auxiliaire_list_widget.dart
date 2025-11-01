import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/data/enums/request_status_enum.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/pharmacien/request_auxiliaire_item_widget.dart';
import 'package:pharmix/app/widgets/pharmacien/unwaitingRequests_auxiliaire_item_widget.dart';
import 'package:pharmix/generated/locales.g.dart';

class RequestAuxiliaireListWidget extends GetView<PharmacienController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: controller.requests.isEmpty
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.selectedRequestStatus.value ==
                  RequestPharmacyStatusEnum.traite ||
              controller.selectedRequestStatus.value ==
                  RequestPharmacyStatusEnum.refused) {
            if (controller.unwaitingsRequests.isEmpty) {
              return SizedBox(
                height: context.height / 1.7,
                child: Center(
                  child: CustomText(
                    text:
                        "${LocaleKeys.no_data.tr} ${controller.selectedRequestStatus.value.label}",
                    style: AppTextStyles.caption,
                  ),
                ),
              );
            }
            return UnwaitingRequestsAuxiliaireItemWidget(
              unwaitingrequests: controller.unwaitingsRequests.value,
              onValidate: (p0) {},
            );
          }
          if (controller.requests.isEmpty) {
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
            itemCount: controller.requests.length,
            itemBuilder: (context, index) => RequestAuxiliaireItemWidget(
              request: controller.requests[index],
              onValidate: (p0) {
                controller.storeRequestResponse(
                    requestId: controller.requests[index].id,
                    data: {'items': p0});
              },
            ),
          );
        })
      ],
    );
  }
}
