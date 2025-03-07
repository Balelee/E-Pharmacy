import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BasketView extends GetView {
  const BasketView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BasketView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BasketView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
