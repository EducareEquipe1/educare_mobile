import 'package:educare/controllers/user_controller.dart';
import 'package:get/get.dart';
// Removed duplicate or invalid import

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}
