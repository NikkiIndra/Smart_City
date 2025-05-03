import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}


