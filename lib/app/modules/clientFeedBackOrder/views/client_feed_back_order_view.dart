import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

import '../controllers/client_feed_back_order_controller.dart';

class ClientFeedBackOrderView extends GetView<ClientFeedBackOrderController> {
  const ClientFeedBackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes traitées'),
      ),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(
            child: Text('Aucune commande traitée pour l’instant.'),
          );
        }
        return ListView.builder(
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
                child: ExpansionTile(
                    initiallyExpanded: true,
                    shape: Border.all(color: Colors.transparent),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Commande #${order.id}',
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
                            borderRadius: BorderRadius.circular(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          // Liste des produits
                          ...order.details.map((item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(width: 0.1))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Produit #${item.orderDetailId}',
                                        style: AppTextStyles.bodyText1Bold,
                                        overflow: TextOverflow.visible,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  text:
                                                      'Quantite : ${item.quantity}'),
                                              CustomText(
                                                  text:
                                                      'Prix : ${item.price} FCFA'),
                                              CustomText(
                                                  text:
                                                      'Total : ${item.total} FCFA'),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: item.available
                                                        ? Colors.green
                                                        : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            child: Icon(
                                              item.available
                                                  ? Icons.check
                                                  : Icons.close,
                                              color: item.available
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
                          // const Divider(),
                          // Total
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomText(
                                text:
                                    'Total: ${order.details.fold<double>(0, (sum, e) => sum + e.total)} FCFA',
                                style: AppTextStyles.heading3.copyWith(
                                    fontSize: 17.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          },
        );
      }),
    );
  }
}
