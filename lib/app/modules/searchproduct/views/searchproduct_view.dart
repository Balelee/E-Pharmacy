import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/searchproduct_controller.dart';

class SearchproductView extends GetView<SearchproductController> {
  const SearchproductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(onPressed: () => Get.back()),
                const Text(
                  'Recherche de prix de médicament',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 25,
                      color: AppColors.textSecondary,
                    ),
                    Positioned(
                      right: -4,
                      top: -10,
                      child: Container(
                        width: 21,
                        height: 21,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "0",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  cursorHeight: 15,
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.searchText.value = value;
                    controller.onSearchChanged(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Tapez nom de médicament...",
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: const Icon(Icons.search),
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
            const SizedBox(height: 10),
            Obx(() {
              final query = controller.searchText.value.trim();
              final results = controller.products;
              if (query.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/no_data.png',
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: results.isEmpty
                      ? const Center(
                          child: Text("Aucun médicament trouvé."),
                        )
                      : ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final medicament = results[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text(
                                        "Détails du médicament",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      content: Container(
                                        width: Get.width,
                                        decoration: const BoxDecoration(
                                          color: AppColors.background,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              medicament.productName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Prix du produit : ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${medicament.price.toStringAsFixed(0)} CFA",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: CustomButton.primaryButton(
                                                padding: EdgeInsets.all(10),
                                                onPressed: () {},
                                                buttonTitle:
                                                    'Ajouter aux favoris',
                                                textStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.background,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  medicament.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              trailing: TextButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.primary,
                                      content: Text(
                                        "${medicament.productName} ajouté au panier",
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_circle_rounded,
                                    color: Colors.blue),
                                label: const Text(
                                  "Ajouter",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
