import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:e_pharma/app/utils/constants/size_constant.dart';
import 'package:e_pharma/app/widgets/category_filter.dart';
import 'package:e_pharma/app/widgets/custom_search_bar.dart';
import 'package:e_pharma/app/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListView extends GetView<ProductController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16, horizontal: SizeConstant.haurizontalPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.height / 14),
              child: CustomSearchBar(
                onSearch: (query) {
                  if (kDebugMode) {
                    print("Recherche : $query");
                  }
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CategoryFilterWidget(),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }
                final filteredProducts = controller.filteredProducts;
                if (filteredProducts.isEmpty) {
                  return const Center(child: Text('Aucun produit disponible'));
                }

                return GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final produit = filteredProducts[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(AppPages.DETAIL_PRODUIT,
                          arguments: produit),
                      child: Card(
                        elevation: 0.6,
                        color: Get.theme.scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12.0))),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    produit.imageUrl ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 50),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                produit.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        padding: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.theme.primaryColor,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Get.theme.cardColor,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
