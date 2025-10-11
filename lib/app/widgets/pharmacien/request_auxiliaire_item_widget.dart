import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/auxiliaire_request.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/data/enums/request_status_enum.dart';
import 'package:pharmix/app/utils/helpers/bottomSheet_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

// ignore: must_be_immutable
class RequestAuxiliaireItemWidget extends StatelessWidget {
  final AuxiliaireRequest request;
  dynamic Function(List<Map<String, Object?>>) onValidate;
  RequestAuxiliaireItemWidget(
      {super.key, required this.request, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    final bool canProcess = request.status == RequestStatusEnum.enattente.value;

    return GestureDetector(
      onTap: () {
        if (canProcess) {
          if (Get.isBottomSheetOpen == false) {
            BottomsheetHelper.commandeDetailBottomSheet(
                request: request, onValidate: onValidate);
          }
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Commande #${request.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: request.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: request.statusLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: request.statusColor,
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
                        text: request.clientPhone,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
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
                        text: "${request.amount.toString()} CFA",
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
                canProcess
                    ? CustomButton.primaryButton(
                        height: 30,
                        elevation: 0.0,
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        onPressed: () {
                          if (Get.isBottomSheetOpen == false) {
                            BottomsheetHelper.commandeDetailBottomSheet(
                                request: request, onValidate: onValidate);
                          }
                        },
                        buttonTitle: "Traiter",
                        backgroundColor: AppColors.success,
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: request.date ?? '',
                      style: AppTextStyles.caption
                          .copyWith(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
