import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmix/app/modules/client/ClientRequestList/controllers/client_request_list_controller.dart';
class ClientRequestListView extends GetView<ClientRequestListController> {
  const ClientRequestListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClientRequestListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClientRequestListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
