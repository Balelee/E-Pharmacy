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
        height: Get.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // 📌 Poignée de drag
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // 📌 Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40), // pour équilibrer avec l'icône
                  const Text(
                    "Détails de la commande",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 📌 Liste des produits
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: details.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = details[index];
                  return Obx(() {
                    final available = item["available"] as RxBool;
                    final customPrice = item["customPrice"] as RxString;
                    final quantity =
                        int.tryParse(item["quantity"].toString()) ?? 0;

                    final unitPrice = double.tryParse(customPrice.value) ??
                        item["price"] as double;
                    final totalPrice = unitPrice * quantity;

                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
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
                                    fontSize: 16,
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
                          const SizedBox(height: 8),

                          // Oui / Non en mode Chip moderne
                          Row(
                            children: [
                              ChoiceChip(
                                label: const Text("Oui"),
                                selected: available.value,
                                selectedColor: Colors.green[100],
                                backgroundColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onSelected: (_) => available.value = true,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: available.value
                                      ? Colors.green
                                      : Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ChoiceChip(
                                label: const Text("Non"),
                                selected: !available.value,
                                selectedColor: Colors.red[100],
                                backgroundColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onSelected: (_) => available.value = false,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: !available.value
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Prix et total
                          if (available.value) ...[
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Prix unitaire (CFA)",
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.money,
                                    color: Colors.green),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onChanged: (value) => customPrice.value = value,
                              controller: TextEditingController(
                                  text: customPrice.value),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Total: ${totalPrice.toStringAsFixed(0)} CFA",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ]
                        ],
                      ),
                    );
                  });
                },
              ),
            ),

            // 📌 Bouton valider
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
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
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
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
