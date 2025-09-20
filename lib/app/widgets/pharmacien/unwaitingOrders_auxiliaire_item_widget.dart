import 'package:flutter/material.dart';
import 'package:pharmix/app/data/models/order_pharmacy.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

class UnwaitingordersAuxiliaireItemWidget extends StatelessWidget {
  final List<OrderPharmacy> unwaitingorders;
  final dynamic Function(List<Map<String, Object?>>) onValidate;
  UnwaitingordersAuxiliaireItemWidget(
      {super.key, required this.unwaitingorders, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      key: const ValueKey('unwaitingorders'),
      padding: const EdgeInsets.all(12),
      itemCount: unwaitingorders.length,
      itemBuilder: (context, index) {
        final order = unwaitingorders[index];
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
                ExpansionTile(
                  childrenPadding: const EdgeInsets.all(3),
                  initiallyExpanded: true,
                  shape: Border.all(color: Colors.transparent),
                  tilePadding: EdgeInsets.all(0.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Requette n°${order.orderId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...order.details!.map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                decoration: const BoxDecoration(
                                    border:
                                        Border(bottom: BorderSide(width: 0.1))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: '${item.orderDetail?.productName}',
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
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: item.available
                                                    ? Colors.green
                                                    : Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomText(
                              text:
                                  'Total: ${order.details!.fold<double>(0, (sum, e) => sum + e.total).toStringAsFixed(0)} FCFA',
                              style: AppTextStyles.heading3.copyWith(
                                  fontSize: 17.0, color: Colors.black),
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
    );
  }
}
