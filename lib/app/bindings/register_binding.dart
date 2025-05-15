import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/auth/register/controller/register_controller.dart';

class RegisterBindins extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}


