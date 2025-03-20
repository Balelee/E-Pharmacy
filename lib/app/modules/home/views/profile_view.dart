import 'package:e_pharma/app/modules/home/controllers/profile_controller.dart';
import 'package:e_pharma/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            CustomButton.secondaryButton(
                onPressed: () =>controller.logOut(), buttonTitle: "Log out")
          ],
        ),
      ),
    );
  }
}
