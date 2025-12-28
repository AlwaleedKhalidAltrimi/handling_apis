import 'package:get/get.dart';
import '../repo/user_repo.dart';
import '../models/user_model.dart';

// Controller for managing all users
class UserGetXController extends GetxController {
  final UserRepo userRepo;

  UserGetXController(this.userRepo);

  final _isLoading = false.obs;
  final _users = <UserModel>[].obs;
  final _errorMessage = ''.obs;
  final _hasError = false.obs;

  bool get isLoading => _isLoading.value;
  List<UserModel> get users => _users;
  String get errorMessage => _errorMessage.value;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      final users = await userRepo.getAllUsers();
      _users.assignAll(users);
    } catch (e) {
      _errorMessage.value = e.toString();
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void resetState() {
    _isLoading.value = false;
    _users.clear();
    _errorMessage.value = '';
    _hasError.value = false;
  }
}

// Controller for managing individual user details
class UserDetailController extends GetxController {
  final UserRepo userRepo;

  UserDetailController(this.userRepo);

  final _isLoading = false.obs;
  final _currentUser = Rxn<UserModel>();
  final _errorMessage = ''.obs;
  final _hasError = false.obs;

  bool get isLoading => _isLoading.value;
  UserModel? get currentUser => _currentUser.value;
  String get errorMessage => _errorMessage.value;
  bool get hasError => _hasError.value;

  Future<void> getUserById(String userId) async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      final user = await userRepo.getUserById(userId);
      _currentUser.value = user;
    } catch (e) {
      _errorMessage.value = e.toString();
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void resetState() {
    _isLoading.value = false;
    _currentUser.value = null;
    _errorMessage.value = '';
    _hasError.value = false;
  }
}
