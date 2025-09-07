import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/home/controllers/cart_controller.dart';

class QuantitySelector extends StatelessWidget {
  final int productId;
  const QuantitySelector({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Obx(() {
      var cartItem = controller.panierList
          .firstWhereOrNull((item) => item.product.id == productId);
      if (cartItem == null) {
        return SizedBox();
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => controller.decrementQuantity(productId),
            icon: Icon(Icons.remove, color: const Color(0xFFF44336)),
          ),
          Text(
            cartItem.quantity.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => controller.incrementQuantity(productId),
            icon: Icon(Icons.add, color: Colors.green),
          ),
        ],
      );
    });
  }
}
