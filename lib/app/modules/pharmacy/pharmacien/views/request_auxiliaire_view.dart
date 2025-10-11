import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/modules/pharmacy/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/data/enums/request_status_enum.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/app/widgets/pharmacien/auxiliaire_header_widget.dart';
import 'package:pharmix/app/widgets/pharmacien/request_auxiliaire_list_widget.dart';
import 'package:pharmix/generated/locales.g.dart';

class RequestAuxiliaireView extends GetView<PharmacienController> {
  const RequestAuxiliaireView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: SizedBox(
          height: context.height,
          child: Column(
            children: [
              const AuxiliaireHeaderWidget(),
              if (controller.showToast.value)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomToast(
                    icon: Icons.info_outline,
                    message: LocaleKeys.toast_auxi_info.tr,
                    backgroundColor: AppColors.success,
                    onClose: () => controller.showToast.value = false,
                  ),
                ),
              _buildHeader(context),
              Expanded(
                  child: SingleChildScrollView(
                      child: RequestAuxiliaireListWidget())),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: LocaleKeys.request_recente.tr,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: PopupMenuButton<RequestPharmacyStatusEnum>(
            padding: EdgeInsets.zero,
            color: AppColors.background,
            icon: Icon(
              Icons.sort,
              size: 25,
              color: AppColors.textSecondary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: RequestPharmacyStatusEnum.traite,
                child: Text(
                  RequestPharmacyStatusEnum.traite.label,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              PopupMenuItem(
                value: RequestPharmacyStatusEnum.refused,
                child: Text(
                  RequestPharmacyStatusEnum.refused.label,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              PopupMenuItem(
                value: RequestPharmacyStatusEnum.enattente,
                child: Text(
                  RequestPharmacyStatusEnum.enattente.label,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
            onSelected: (value) async {
              controller.selectedRequestStatus.value = value;
              controller.isLoading.value = true;
              controller.loadRequestsData();
            },
          ),
        )
      ],
    );
  }
}
