import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsController extends GetxController {
  var cameraAllowed = false.obs;
  var locationAllowed = false.obs;

  @override
  void onInit() {
    checkPermissions();
    super.onInit();
  }

  void checkPermissions() async {
    cameraAllowed.value = await Permission.camera.isGranted;
    locationAllowed.value = await Permission.location.isGranted;
  }

  void openSettingsAndRefresh() async {
    await openAppSettings();
    Future.delayed(const Duration(seconds: 1), () => checkPermissions());
  }
}
