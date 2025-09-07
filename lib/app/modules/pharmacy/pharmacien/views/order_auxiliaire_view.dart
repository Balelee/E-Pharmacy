import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/widgets/pharmacien/auxiliaire_header_widget.dart';
import 'package:pharmix/app/widgets/pharmacien/order_auxiliaire_list_widget.dart';

class OrderAuxiliaireView extends GetView {
  const OrderAuxiliaireView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuxiliaireHeaderWidget(),
        Expanded(
          child: SingleChildScrollView(
            child: OrderAuxiliaireListWidget(),
          ),
        ),
      ],
    );
  }
}
