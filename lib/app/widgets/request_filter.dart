import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/modules/client/ClientRequestList/controllers/client_request_list_controller.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';

class RequestFilterWidget extends StatelessWidget {
  final ClientRequestListController controller = Get.find<ClientRequestListController>();

  RequestFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              controller.requestStatus.map((TypeModel status) {
            bool isSelected = controller.selectedStatus.value == status;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                side: const BorderSide(color: Colors.transparent),
                label: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      status.label??'' ,
                      style: isSelected
                          ? AppTextStyles.bodyText1PrimaryBold
                          : AppTextStyles.bodyText1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        decoration: BoxDecoration(
                            color: isSelected
                                ? Get.theme.primaryColor
                                : Get.theme.cardColor,
                            border: !isSelected
                                ? Border.all(
                                    color: Get.textTheme.bodyMedium!.color ??
                                        Colors.transparent)
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          status.count.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Get.theme.cardColor
                                : Get.textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                selected: isSelected,
                selectedColor: Get.theme.primaryColor.withOpacity(0.15),
                backgroundColor: Get.theme.cardColor,
                showCheckmark: false,
                onSelected: (bool selected) {
                  if (selected) {
                    controller.updateRequestStatus(status);
                  }
                },
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
