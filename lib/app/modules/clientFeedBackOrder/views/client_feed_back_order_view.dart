import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import '../controllers/client_feed_back_order_controller.dart';

class ClientFeedBackOrderView extends GetView<ClientFeedBackOrderController> {
  const ClientFeedBackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Obx(
          () => CustomText(
            text: controller.isProcessing.value
                ? 'Traitement encours'
                : 'Commandes traitées',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            ));

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
          child: controller.isProcessing.value
              ? Container(
                  key: const ValueKey('processing'),
                  color: Colors.white.withOpacity(0.8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: LinearProgressIndicator(
                            minHeight: 4,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomText(
                            text: controller.currentProcessingMessage,
                            style: AppTextStyles.heading3.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomText(
                          text: "Temps écoulé : ${controller.elapsedTime}",
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : controller.orders.isEmpty
                  ? const Center(
                      key: ValueKey('empty'),
                      child: CustomText(
                          text: 'Aucune commande traitée pour l’instant.'),
                    )
                  : ListView.builder(
                      key: const ValueKey('orders'),
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        final order = controller.orders[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (order.status.toLowerCase() != 'expiré')
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Get.width / 2,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: CustomText(
                                          text:
                                              "Pharmacie ${order.pharmacy.name.toString()}",
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.error.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 13,
                                              color: AppColors.error,
                                            ),
                                            const SizedBox(width: 4),
                                            Obx(() {
                                              final distance = controller
                                                      .distances[order.id] ??
                                                  0.0;
                                              return CustomText(
                                                text:
                                                    "Situé: ${distance.toStringAsFixed(1)} km",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.error,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 3),
                                ExpansionTile(
                                  childrenPadding: const EdgeInsets.all(3),
                                  initiallyExpanded: true,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Commande #${order.id}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          order.status.toUpperCase(),
                                          style: AppTextStyles.caption
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        ...order.details.map((item) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0.1))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          '${item.orderDetails?.productName}',
                                                      style: AppTextStyles
                                                          .bodyText1Bold,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                                text:
                                                                    'Quantite dispo : ${item.quantity}'),
                                                            CustomText(
                                                                text:
                                                                    'Prix dispo : ${item.price.toStringAsFixed(0)} FCFA'),
                                                            CustomText(
                                                                text:
                                                                    'Total : ${item.total.toStringAsFixed(0)} FCFA'),
                                                          ],
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: item
                                                                        .available
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                          ),
                                                          child: Icon(
                                                            item.available
                                                                ? Icons.check
                                                                : Icons.close,
                                                            color: item
                                                                    .available
                                                                ? Colors.green
                                                                : Colors.red,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: CustomText(
                                              text:
                                                  'Total: ${order.details.fold<double>(0, (sum, e) => sum + e.total).toStringAsFixed(0)} FCFA',
                                              style: AppTextStyles.heading3
                                                  .copyWith(
                                                      fontSize: 17.0,
                                                      color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      }),
    );
  }
}
