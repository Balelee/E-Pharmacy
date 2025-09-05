import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/client_order_list_controller.dart';

class ClientOrderListView extends GetView<ClientOrderListController> {
  const ClientOrderListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClientOrderListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClientOrderListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
