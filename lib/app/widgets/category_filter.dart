import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/home/controllers/product_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class CategoryFilterWidget extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();
  CategoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.productFilters.map((category) {
            bool isSelected = controller.selectedCategory.value == category;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                checkmarkColor: AppColors.secondary,
                side: isSelected
                    ? null
                    : BorderSide(color: Get.theme.primaryColor),
                label: Text(
                  category.label!,
                  style: TextStyle(
                      color: isSelected
                          ? AppColors.secondary
                          : Get.theme.primaryColor),
                ),
                selected: isSelected,
                selectedColor: Get.theme.primaryColor,
                onSelected: (bool selected) {
                  if (selected) {
                    controller.updateCategory(category);
                  }
                },
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
