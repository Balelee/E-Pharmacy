// lib/app/common/controllers/user_controller.dart
import 'package:get/get.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final UserRepository _userRepo;
  final Rxn<User> userRx = Rxn<User>();

  UserController(this._userRepo);

  User? get user => userRx.value;
  bool get isLoggedIn => userRx.value != null;

  @override
  void onInit() {
    _loadUser();
    super.onInit();
  }

  Future<void> _loadUser() async {
    userRx.value = await _userRepo.getUser();
  }

  Future<void> login(User user) async {
    await _userRepo.saveUser(user);
    userRx.value = user;
  }

  Future<void> logout() async {
    await _userRepo.clearUser();
    userRx.value = null;
  }

  Future<void> updateUser(User updatedUser) async {
    await _userRepo.saveUser(updatedUser);
    userRx.value = updatedUser;
  }
}