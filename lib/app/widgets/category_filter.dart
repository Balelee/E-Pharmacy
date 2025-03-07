import 'package:e_pharma/app/modules/home/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryFilterWidget extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.categories.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                label: Text(category),
                selected: controller.selectedCategory.value == category,
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
