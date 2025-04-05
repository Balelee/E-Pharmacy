import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
                  child: Image.asset(
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text(
            'Catrin Crane',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text('@Catrin | Joined August 2023',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          ProfileField(label: 'Email', value: 'catrin.crane@design.com'),
          ProfileField(label: 'Phone number', value: '(204) 751-8623'),
          ProfileField(
              label: 'Address', value: '20 Cooper Square, New York 10003'),
          ProfileField(label: 'Password', value: '************'),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          TextField(
            decoration: InputDecoration(
              hintText: value,
              suffixIcon: Icon(Icons.edit, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
