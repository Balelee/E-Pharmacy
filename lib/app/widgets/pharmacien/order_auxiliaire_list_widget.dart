import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/pharmacien/controllers/pharmacien_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/app/widgets/pharmacien/order_auxiliaire_item_widget.dart';

class OrderAuxiliaireListWidget extends GetView<PharmacienController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.showToast.value)
            CustomToast(
              icon: Icons.info_outline,
              message:
                  "Cher auxiliaire, Merci de vérifier chaque commande client afin de valider ou annuler selon la situation.",
              backgroundColor: AppColors.success,
              onClose: () => controller.showToast.value = false,
            ),
          const SizedBox(height: 20),
          _buildHeader(context),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.orders.isEmpty) {
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(color: Colors.green),
                    SizedBox(height: 5),
                    CustomText(text: "Aucune commande récente"),
                  ],
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.orders.length,
              itemBuilder: (context, index) =>
                  OrderAuxiliaireItemWidget(order: controller.orders[index]),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Commandes récentes",
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
          child: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            color: AppColors.background,
            icon: Icon(
              Icons.sort,
              size: 25,
              color: AppColors.textSecondary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'traite',
                child: Text(
                  "Commd validé",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              PopupMenuItem(
                value: 'annule',
                child: Text(
                  "Commd annulé",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              PopupMenuItem(
                value: 'Tous',
                child: Text(
                  "Tous les commandes",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'traite') {
                await controller.fetchOrdersByStatus('traite');
              } else if (value == 'annule') {
                await controller.fetchOrdersByStatus('annule');
              } else {
                controller.selectedStatus.value = '';
                controller.loadOrdersData();
              }
            },
          ),
        )
      ],
    );
  }
}
