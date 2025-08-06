import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/enums/orderstatus.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import '../controllers/orderpharmacien_controller.dart';

class OrderpharmacienView extends GetView<OrderpharmacienController> {
  const OrderpharmacienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const CustomText(
          text: 'Suivi des Commandes',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: CustomText(
                          text: controller.orders.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.showToast.value
                  ? CustomToast(
                      icon: Icons.info_outline,
                      message:
                          "Cher auxiliaire, Merci de vérifier chaque commande client afin de valider ou annuler selon la situation.",
                      backgroundColor: AppColors.primary.withOpacity(0.6),
                      onClose: () {
                        controller.showToast.value = false;
                      },
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        cursorHeight: 15,
                        onChanged: (value) {
                          // controller.onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Rechercher une commande...',
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.search, color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Bouton de tri
                  Container(
                    width: 50,
                    height: 50,
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
                            "Tous",
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
              ),
              const SizedBox(height: 25),
              CustomText(
                text: controller.selectedStatus.value == 'traite'
                    ? "Liste des commandes validées"
                    : controller.selectedStatus.value == 'annule'
                        ? "Liste des commandes annulées"
                        : "Liste des commandes",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              controller.orders.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/no_data.png',
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: CustomText(
                            text: "Aucune commande en attente disponible",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          final order = controller.orders[index];
                          return Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Commande #${order.id}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CustomText(
                                      text: order.status.label == "Traité"
                                          ? "Validé"
                                          : order.status.label == "Annulé"
                                              ? "Annulé"
                                              : "",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: order.status.label == "Traité"
                                            ? Colors.green
                                            : order.status.label == "Annulé"
                                                ? Colors.red
                                                : Colors.transparent,
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
                                            text: 'Produits : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: 13,
                                            ),
                                          ),
                                          TextSpan(
                                            text: order.orderDetails
                                                .map((e) => e.productName)
                                                .join(', '),
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
                                            text:
                                                "${order.amount.toString()} CFA",
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
                                    const SizedBox(height: 10),
                                    order.status.label != "Traité" &&
                                            order.status.label != "Annulé"
                                        ? Row(
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.green),
                                                  ),
                                                  child: Text(
                                                    "Valider",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.updateOrderStatus(
                                                      order.id, "traite");
                                                },
                                              ),
                                              SizedBox(width: 8),
                                              GestureDetector(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.red),
                                                  ),
                                                  child: Text(
                                                    "Annuler",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.updateOrderStatus(
                                                      order.id, "annule");
                                                },
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
