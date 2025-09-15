import 'package:get/get.dart';
import 'package:pharmix/app/data/models/pharmacy.dart';
import 'package:pharmix/app/data/models/user.dart';
import 'package:pharmix/app/data/providers/adminProvider/admin_provider.dart';
import 'package:pharmix/app/data/providers/pharmacy_provider.dart';

class AdminhomeController extends GetxController {
  RxList<User> users = <User>[].obs;
  AdminProvider adminProvider = AdminProvider();
  PharmacyProvider pharmacieProvider = PharmacyProvider();
  var roles = <String>[
    "Pharmacien",
    "Client",
    "Admin",
  ].obs;
  RxList<Pharmacy> pharmacies = <Pharmacy>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final allUsers = await adminProvider.fetchUsers();
    for (var u in allUsers) {
      if (u.role != null) {
        u.type = u.role!.capitalizeFirst;
      }
    }
    users.assignAll(allUsers);
  }

  void assignRole(User user, String role) {
    user.type = role;
    users.refresh();
  }

  void assignPharmacy(User user, Pharmacy pharmacy) {
    user.pharmacie = pharmacy;
    users.refresh();
  }

  void toggleUserStatus(User user, String status) {
    user.status = status;
    users.refresh();
  }
}
