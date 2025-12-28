import 'package:get/get.dart';
import '../repo/user_repo.dart';
import '../services/api_services.dart';
import '../controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServices>(
      () => ApiServices(ApiServices.createAndSetupDio()),
    );

    Get.lazyPut<UserRepo>(() => UserRepo(Get.find<ApiServices>()));

    Get.lazyPut<UserGetXController>(
      () => UserGetXController(Get.find<UserRepo>()),
    );

    Get.lazyPut<UserDetailController>(
      () => UserDetailController(Get.find<UserRepo>()),
    );
  }
}
