import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import '../controllers/adminhome_controller.dart';

class AdminhomeView extends GetView<AdminhomeController> {
  const AdminhomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const CustomText(
          text: "Attribuer rôles & pharmacies",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const CustomText(
                  text: "Aucun utilisateur trouvé",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Gestion des utilisateurs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                      text: "Nom",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomText(
                      text: "Rôle",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomText(
                      text: "Pharmacie",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomText(
                      text: "Actions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final user = controller.users[index];
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomText(
                            text: user.fullName,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: controller.roles.contains(user.role)
                                  ? user.role
                                  : null,
                              hint: const CustomText(
                                text: "Sélectionner",
                                style: TextStyle(fontSize: 10),
                              ),
                              items: controller.roles
                                  .map((role) => DropdownMenuItem(
                                        value: role,
                                        child: CustomText(
                                          text: role,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  controller.assignRole(user, val);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SearchableDropdown<Pharmacy>.paginated(
                            searchHintText: "Recherche...",
                            trailingClearIcon: Icon(Icons.arrow_drop_down),
                            trailingIcon: const Icon(Icons.arrow_drop_down),
                            hintText: const CustomText(
                              text: "Sélectionner",
                              style: TextStyle(fontSize: 11),
                            ),
                            isDialogExpanded: true,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            requestItemCount: 10,
                            paginatedRequest:
                                (int pageKey, String? searchKey) async {
                              final pharmacies = await controller
                                  .pharmacieProvider
                                  .fetchPharmacies(
                                pageKey: pageKey,
                                query: searchKey,
                              );
                              return pharmacies
                                  .map((p) => SearchableDropdownMenuItem(
                                        value: p,
                                        label: p.name ?? '',
                                        child: CustomText(
                                          text: p.name ?? '',
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ))
                                  .toList();
                            },
                            onChanged: (Pharmacy? value) {
                              if (value != null) {
                                controller.assignPharmacy(user, value);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 0.6,
                                  child: Row(
                                    children: [
                                      Switch(
                                        value: user.isActif,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.primary,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor:
                                            Colors.grey.shade400,
                                        onChanged: (val) {
                                          controller.toggleUserStatus(
                                            user,
                                            val ? "actif" : "inactif",
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.save,
                                          size: 33,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
