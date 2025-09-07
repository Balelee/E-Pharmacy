import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import '../controllers/receiptpay_controller.dart';

class ReceiptpayView extends GetView<ReceiptpayController> {
  const ReceiptpayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: AppColors.background,
                ),
                CustomText(
                  text: 'Paiement Reçu',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.share,
                    color: AppColors.background,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: '🧾 Reçu de Commande',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.check_circle_outline_outlined,
                size: 25,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildInfoRow("Pharmacie", "Santé Plus"),
          _buildInfoRow("Adresse", "Ouagadougou, 1200 logements"),
          _buildInfoRow("Téléphone", "+226 70 00 00 00"),
          const Divider(height: 20),
          _buildInfoRow("Reçu N°", "CMD-20250718-0012"),
          _buildInfoRow("Date", "18/07/2025 - 14h22"),
          const Divider(height: 20),
          _buildInfoRow("Client", "KABORE Aline"),
          _buildInfoRow("Téléphone", "+226 78 12 34 56"),
          _buildInfoRow("Adresse Livraison", "Ouaga 2000, rue 12.123"),
          const Divider(height: 20),
          const Text("Produits commandés :",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          _buildProductRow("Doliprane 500mg", 2, 1000),
          _buildProductRow("Bétadine 10%", 1, 800),
          _buildProductRow("Vitamine C 1000mg", 1, 500),
          const Divider(height: 20),
          _buildInfoRow("Total TTC", "2 300 FCFA"),
          _buildInfoRow("Frais livraison", "500 FCFA"),
          _buildInfoRow("Montant payé", "2 800 FCFA"),
          _buildInfoRow("Mode de paiement", "Orange Money"),
          const Divider(height: 20),
          Text("Merci pour votre commande ! 👋"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.green)),
            child: CustomButton.secondaryButton(
              onPressed: () {},
              buttonTitle: "Telecharger PDF",
              textStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textColor: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          Text(value,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildProductRow(String name, int quantity, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name)),
          Text("x$quantity"),
          Text("${price * quantity} FCFA"),
        ],
      ),
    );
  }
}
