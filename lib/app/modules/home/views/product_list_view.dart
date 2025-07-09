import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pharmix/app/data/models/product.dart';
import 'package:pharmix/app/modules/home/controllers/product_controller.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/size_constant.dart';
import 'package:pharmix/app/widgets/category_filter.dart';
import 'package:pharmix/app/widgets/custom_search_bar.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/generated/locales.g.dart';

class ProductListView extends GetView<ProductController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: BackButton(
            color: AppColors.background,
            onPressed: () {
              Get.toNamed(AppPages.BASE);
            },
          ),
          title: CustomText(
            text: "Boutique des produits",
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
                  Icons.shop,
                  color: AppColors.background,
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: SizeConstant.haurizontalPadding)
              .copyWith(bottom: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: CustomSearchBar(
                  onSearch: (query) {
                    controller.fetchResearchData(label: query);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Filtrer par pharmacie",
                        style: AppTextStyles.bodyText1Bold.copyWith(
                            color: Get.theme.textTheme.bodyLarge?.color
                                ?.withOpacity(0.4)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: CategoryFilterWidget(),
              ),
              Expanded(
                child: PagedGridView<int, Product>(
                  pagingController: controller.pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  padding: EdgeInsets.all(0.0),
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    itemBuilder: (context, produit, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(AppPages.DETAIL_PRODUIT,
                            arguments: produit),
                        child: Card(
                          elevation: 1.0,
                          color: Get.theme.scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    "assets/images/productimg.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  produit.name,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  produit.pharmacieName!,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Stock: ${produit.stock}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "${produit.price} F",
                                      style: AppTextStyles.bodyText1Bold,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          controller.addToCart(produit),
                                      child: Container(
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.theme.primaryColor,
                                        ),
                                        child: Icon(Icons.add,
                                            color: Get.theme.cardColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) => Center(
                        child: CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    )),
                    newPageProgressIndicatorBuilder: (_) => Center(
                        child: CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    )),
                    noItemsFoundIndicatorBuilder: (_) =>
                        Center(child: Text(LocaleKeys.no_product.tr)),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                badgeStyle:
                    badges.BadgeStyle(badgeColor: Get.theme.primaryColor),
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
      ),
    );
  }
}
