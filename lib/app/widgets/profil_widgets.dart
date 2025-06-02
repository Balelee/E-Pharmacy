import 'package:e_pharma/app/cummon/controllers/user_controller.dart';
import 'package:e_pharma/app/modules/home/controllers/profile_controller.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileHeader extends StatelessWidget {
  String? userAvatar;
  ProfileHeader({super.key, required this.userAvatar});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: Get.height / 4.5,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.6),
              image: DecorationImage(
                image: AssetImage('assets/images/couverture-profile1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: -40,
            left: screenWidth / 2 - 40,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: userAvatar != null
                      ? Image.network(userAvatar!)
                      : Image.asset(
                          'assets/images/profile.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, stackTrace) =>
                              Icon(Icons.person, size: 40),
                        ),
                ),
              ),
            ),
          ),

          // Settings button
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.settings, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Obx(() {
      final user = userController.user;
      if (user == null) return Center(child: CircularProgressIndicator());

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              '${user.firstname ?? ''} ${user.lastname ?? ''}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('@${user.firstname ?? ''} | Joined ${user.joinedAt ?? ''}',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ProfileField(
              field: 'firstname',
              label: 'First Name',
              value: user.firstname ?? '',
            ),
            ProfileField(
              field: 'lastname',
              label: 'Last Name',
              value: user.lastname ?? '',
            ),
            ProfileField(
              field: 'email',
              label: 'Email',
              value: user.email ?? '',
            ),
            ProfileField(
              field: 'phone',
              label: 'Phone number',
              value: user.phone ?? '',
            ),
            ProfileField(
              field: 'address',
              label: 'Address',
              value: user.address ?? '',
            ),
          ],
        ),
      );
    });
  }
}

class ProfileField extends StatelessWidget {
  final String field;
  final String label;
  final String value;

  const ProfileField({
    super.key,
    required this.field,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    final profileController = Get.find<ProfileController>();

    return Obx(() {
      final isEditing = profileController.isEditing(field);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey)),
            if (isEditing)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () async {
                      await profileController.updateField(
                        field: field,
                        value: controller.text,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: profileController.cancelEditing,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 16,
                      color: Get.theme.disabledColor,
                    ),
                    onPressed: () => profileController.startEditing(field),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
