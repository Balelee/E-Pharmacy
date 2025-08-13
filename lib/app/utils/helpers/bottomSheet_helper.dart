import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/order.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class BottomsheetHelper {
  static Future<Widget?> commandeDetailBottomSheet({required Order order}) {
    final details = order.orderDetails.map((e) {
      return {
        "productName": e.productName,
        "price": e.priceUnitaire,
        "quantity": e.quantity,
        "available": RxBool(false),
        "customPrice": RxString(e.priceUnitaire.toString()),
      };
    }).toList();

    return Get.bottomSheet<Widget>(
      isDismissible: false,
      Container(
        width: Get.width,
        height: Get.height * 0.75,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Détails de la commande",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                itemCount: details.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey[300], height: 25),
                itemBuilder: (context, index) {
                  final item = details[index];
                  return Obx(() {
                    final available = item["available"] as RxBool;
                    final customPrice = item["customPrice"] as RxString;
                    final quantity = int.tryParse(item["quantity"] as String);

                    // calcul dynamique du total
                    final unitPrice = double.tryParse(customPrice.value) ??
                        item["price"] as double;
                    final totalPrice = unitPrice * quantity!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nom du produit + quantité
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item["productName"].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              "Qté: $quantity",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Oui / Non
                        Row(
                          children: [
                            ChoiceChip(
                              label: const Text("Oui"),
                              selected: available.value,
                              selectedColor: Colors.green[100],
                              onSelected: (_) => available.value = true,
                              labelStyle: TextStyle(
                                color: available.value
                                    ? Colors.green
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text("Non"),
                              selected: !available.value,
                              selectedColor: Colors.red[100],
                              onSelected: (_) => available.value = false,
                              labelStyle: TextStyle(
                                color: !available.value
                                    ? Colors.red
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Champ prix + total si disponible
                        if (available.value) ...[
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Prix unitaire (CFA)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            onChanged: (value) => customPrice.value = value,
                            controller: TextEditingController(
                              text: customPrice.value,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Total: ${totalPrice.toStringAsFixed(0)} CFA",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ]
                      ],
                    );
                  });
                },
              ),
            ),

            // Bouton valider
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final result = details.map((d) {
                    final available = d["available"] as RxBool;
                    final customPrice = d["customPrice"] as RxString;
                    final quantity = int.tryParse(d["quantity"].toString());

                    return {
                      "productName": d["productName"],
                      "available": available.value,
                      "quantity": quantity,
                      "price": available.value
                          ? double.tryParse(customPrice.value) ?? d["price"]
                          : null,
                      "total": available.value
                          ? (double.tryParse(customPrice.value) ??
                                  d["price"] as double) *
                              quantity!
                          : null,
                    };
                  }).toList();

                  print("Résultat final: $result");
                  Get.back();
                },
                child: const Text(
                  "Valider",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
