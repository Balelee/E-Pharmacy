import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/home/controllers/product_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/generated/locales.g.dart';
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
          text: LocaleKeys.appbar_searproduct_msg.tr,
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
                controller.showToast.value
                    ? CustomToast(
                        icon: Icons.info_outline,
                        message: LocaleKeys.toast_msg_searhproduct.tr,
                        backgroundColor: AppColors.primary.withOpacity(0.6),
                        onClose: () {
                          controller.showToast.value = false;
                        },
                      )
                    : SizedBox.shrink(),
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
                            hintText: LocaleKeys.searchproduct_title.tr,
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
                                  LocaleKeys.msg_info_searchproduct.tr,
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
                            color: AppColors.background,
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
                              ? Center(
                                  child: Text(
                                    LocaleKeys.introuvable_medicament.tr,
                                  ),
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
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              builder: (_) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width: 40,
                                                          height: 4,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[400],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        LocaleKeys
                                                            .detail_medicament
                                                            .tr,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text(
                                                        medicament.productName,
                                                        style: const TextStyle(
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
                                                          Text(
                                                            LocaleKeys
                                                                .price_product
                                                                .tr,
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
                                                      const SizedBox(
                                                          height: 20),
                                                      CustomButton
                                                          .primaryButton(
                                                        backgroundColor:
                                                            Colors.green,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        onPressed: () {
                                                          final cartController =
                                                              Get.find<
                                                                  ProductController>();
                                                          cartController.addToCart(
                                                              medicament
                                                                  .toProduct());
                                                          DialogHelper
                                                              .showSuccessSnackbar(
                                                            title: medicament
                                                                .productName,
                                                            message: LocaleKeys
                                                                .panier_success_msg
                                                                .tr,
                                                            seconds: 3,
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        buttonTitle: LocaleKeys
                                                            .ajouter_panier.tr,
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .background,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              medicament.productName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textSecondary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              final cartController =
                                                  Get.find<ProductController>();
                                              cartController.addToCart(
                                                  medicament.toProduct());
                                              DialogHelper.showSuccessSnackbar(
                                                title: medicament.productName,
                                                message: LocaleKeys
                                                    .panier_success_msg.tr,
                                                seconds: 3,
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_rounded,
                                                color: Colors.white),
                                            padding: EdgeInsets.zero,
                                            iconSize: 24,
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
