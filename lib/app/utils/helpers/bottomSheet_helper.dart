import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/helpers/app_theme_helper.dart';
import 'package:pharmix/app/widgets/custom_text.dart';

class BottomsheetHelper {
  static Future<Widget?> commandeDetailBottomSheet(
      {required Request request,
      required Function(List<Map<String, Object?>> result) onValidate}) {
    final details = request.requestDetails.map((e) {
      final quantity = RxInt(int.tryParse(e.quantity.toString()) ?? 1);
      final customPrice = RxString(e.priceUnitaire.toString());
      final total = RxDouble(
        (double.tryParse(customPrice.value) ?? 0.0) * quantity.value,
      );
      final quantityController =
          TextEditingController(text: quantity.value.toString());
      final priceController = TextEditingController(text: customPrice.value);
      return {
        "id": e.id,
        "productName": e.productName,
        "price": double.tryParse(e.priceUnitaire.toString()) ?? 0.0,
        "quantity": quantity,
        "available": RxBool(false),
        "customPrice": customPrice,
        "total": total,
        "quantityController": quantityController,
        "priceController": priceController,
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
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
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
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(Get.context!).unfocus(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: details.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = details[index];
                    return Obx(() {
                      final available = item["available"] as RxBool;
                      final customPrice = item["customPrice"] as RxString;
                      final quantity = item["quantity"] as RxInt;
                      final total = item["total"] as RxDouble;
                      final quantityController =
                          item["quantityController"] as TextEditingController;
                      final priceController =
                          item["priceController"] as TextEditingController;

                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["productName"].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ChoiceChip(
                                  label: const Text("Oui"),
                                  selected: available.value,
                                  selectedColor: Colors.green[100],
                                  backgroundColor: Colors.grey[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
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
                                  label: Text("Non"),
                                  selected: !available.value,
                                  selectedColor: Colors.red[100],
                                  backgroundColor: Colors.grey[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
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
                            if (available.value) ...[
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
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
                                ),
                                onChanged: (value) {
                                  customPrice.value = value;
                                  final unit =
                                      double.tryParse(customPrice.value) ?? 0.0;
                                  total.value = unit * quantity.value;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: quantityController,
                                decoration: InputDecoration(
                                  labelText: "Quantité",
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                      Icons.format_list_numbered,
                                      color: Colors.green),
                                ),
                                onChanged: (value) {
                                  quantity.value = int.tryParse(value) ?? 1;
                                  final unit =
                                      double.tryParse(customPrice.value) ?? 0.0;
                                  total.value = unit * quantity.value;
                                },
                              ),
                              const SizedBox(height: 4),
                              Obx(() => Text(
                                    "Total: ${total.value.toStringAsFixed(0)} CFA",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.blue),
                                  )),
                            ],
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
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
                  ),
                  onPressed: () {
                    final result = details.map((d) {
                      final available = d["available"] as RxBool;
                      final customPrice = d["customPrice"] as RxString;
                      final quantity = (d["quantity"] as RxInt).value;
                      final total = (d["total"] as RxDouble).value;

                      return {
                        "id": d["id"],
                        "productName": d["productName"],
                        "available": available.value,
                        "quantity": quantity,
                        "price": available.value
                            ? double.tryParse(customPrice.value) ??
                                (d["price"] as double)
                            : (d["price"] as double),
                        "total": total,
                      };
                    }).toList();
                    Get.back();
                    onValidate.call(result);
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

  static Future<dynamic> displayBottomSheet({
    required List<Widget> content,
    Widget? action,
    bool isDismissible = true,
    String? title,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    void Function()? onBottomSheetClose,
    VoidCallback? onReport,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    Widget? headerAction,
  }) {
    final theme = GetTheme.to.theme;
    return Get.bottomSheet(
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(Get.context!).unfocus(),
        child: SafeArea(
          top: false,
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.2,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 10)
                        .copyWith(top: 2.0),
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    // === Petit trait draggable ===
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onVerticalDragUpdate: (details) {
                              // Permet au DraggableScrollableSheet de récupérer le drag
                              Scrollable.ensureVisible(context);
                            },
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 18),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // === Header ===
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: title ?? "",
                          style: AppTextStyles.heading4.copyWith(),
                        ),
                        headerAction ?? const SizedBox.shrink(),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // === Contenu scrollable ===
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: mainAxisAlignment,
                          crossAxisAlignment: crossAxisAlignment,
                          children: content,
                        ),
                      ),
                    ),

                    if (action != null) ...[
                      const SizedBox(height: 15),
                      action,
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: true,
    ).then((value) {
      onBottomSheetClose?.call();
      return null;
    });
  }
}
