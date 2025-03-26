import 'package:e_pharma/app/data/models/product.dart';
import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/widgets/category_filter.dart';
import 'package:e_pharma/app/widgets/custom_search_bar.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:e_pharma/generated/locales.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListView extends GetView<ProductController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16, horizontal: SizeConstant.haurizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.height / 14),
                child: CustomSearchBar(
                  onSearch: (query) {
                    controller.fetchResearchData(label: query);
                  },
                  onPhotoTaken: (image) {
                    if (image != null) {
                      if (kDebugMode) {
                        print("Photo prise : ${image.path}");
                      }
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      CustomText(
                        text: ".Produits",
                        style: AppTextStyles.bodyText1Bold,
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
                                  child: produit.imageUrl != null &&
                                          produit.imageUrl!.isNotEmpty
                                      ? Image.network(
                                          produit.imageUrl!,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.broken_image,
                                                      size: 50),
                                        )
                                      : const Icon(Icons.broken_image,
                                          size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  produit.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                        padding: EdgeInsets.all(6.0),
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
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    noItemsFoundIndicatorBuilder: (_) =>
                        Center(child: Text(LocaleKeys.no_product.tr)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
