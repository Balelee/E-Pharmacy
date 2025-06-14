import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/product_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import '../controllers/searchproduct_controller.dart';
import 'package:badges/badges.dart' as badges;

class SearchproductView extends GetView<SearchproductController> {
  const SearchproductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: BackButton(
          color: AppColors.background,
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          text: 'Recherche de prix de médicament',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.medication,
                color: AppColors.background,
              )),
        ],
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomToast(
                  icon: Icons.info_outline,
                  message:
                      "Trouvez rapidement le prix d’un médicament en entrant son nom dans la barre de recherche.",
                  backgroundColor: AppColors.primary.withOpacity(0.6),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Container(
                        width: Get.width / 1.3,
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
                              child: const Icon(
                                Icons.search,
                                color: Colors.green,
                              ),
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
                      child: GestureDetector(
                        child: Icon(
                          Icons.import_export,
                          size: 25,
                          color: controller.iconColor.value,
                        ),
                        onTap: () {
                          controller.sortByName();
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: controller.searchText.value.trim().isEmpty
                      ? Container(
                          color: Colors.green.shade100,
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green.shade100,
                                radius: 80,
                                child: Image.asset(
                                  'assets/images/no_data.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Tapez un nom pour rechercher un médicament.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
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
                          child: controller.products.isEmpty
                              ? const Center(
                                  child: Text("Aucun médicament trouvé."),
                                )
                              : NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (!controller.isLoadingMore.value &&
                                        scrollInfo.metrics.pixels >=
                                            scrollInfo.metrics.maxScrollExtent -
                                                200 &&
                                        controller.hasMore.value) {
                                      controller.loadMoreProducts();
                                      return true;
                                    }
                                    return false;
                                  },
                                  child: ListView.builder(
                                    itemCount: controller.products.length +
                                        (controller.isLoadingMore.value
                                            ? 1
                                            : 0),
                                    itemBuilder: (context, index) {
                                      if (index == controller.products.length) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: AppColors.background,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final medicament =
                                          controller.products[index];
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                content: Container(
                                                  width: Get.width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.background,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        medicament.productName,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Prix du produit : ",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${medicament.price.toStringAsFixed(0)} CFA",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 20.0),
                                                        child: CustomButton
                                                            .primaryButton(
                                                          backgroundColor:
                                                              Colors.green,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          onPressed: () {
                                                            final cartController =
                                                                Get.find<
                                                                    ProductController>();
                                                            cartController
                                                                .addToCart(
                                                                    medicament
                                                                        .toProduct());
                                                            DialogHelper
                                                                .showSuccessSnackbar(
                                                              title: medicament
                                                                  .productName,
                                                              message:
                                                                  "a été ajouté au panier.",
                                                              seconds: 3,
                                                            );
                                                          },
                                                          buttonTitle:
                                                              'Ajouter au panier',
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: AppColors
                                                                .background,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                            final cartController =
                                                Get.find<ProductController>();
                                            cartController.addToCart(
                                                medicament.toProduct());
                                            DialogHelper.showSuccessSnackbar(
                                              title: medicament.productName,
                                              message:
                                                  "a été ajouté au panier.",
                                              seconds: 3,
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.add_circle_rounded,
                                              color: Colors.green),
                                          label: const Text(
                                            "Ajouter",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                ),
              ],
            ),
          )),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: Colors.white,
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            Get.toNamed(AppPages.BASKET);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: badges.Badge(
              badgeContent: Text(
                controller.cartController.panierList.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.green),
              showBadge: controller.cartController.panierList.isNotEmpty,
              child: Icon(
                Icons.shopping_cart,
                color: Get.theme.disabledColor,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
