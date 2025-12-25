import '../models/user_model.dart';
import '../services/api_services.dart';

class UserRepo {
  final ApiServices apiServices;

  UserRepo(this.apiServices);

  Future<List<UserModel>> getAllUsers() async {
    var response = await apiServices.getAllUsers();
    return response.map((user) => UserModel.fromJson(user.toJson())).toList();
  }
}
