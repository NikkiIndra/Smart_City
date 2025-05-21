import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/controllers/alarm_controller.dart';
import 'package:iofes_android_apps_smart_city/app/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:iofes_android_apps_smart_city/app/pages/settings/controllers/settings_controller.dart';

// Import semua controller yang dibutuhkan
import '../controller/navbar_controller.dart';
// ... dan seterusnya

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Semua controller yang akan digunakan di seluruh app
    Get.lazyPut<NavBarController>(() => NavBarController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<AlarmController>(() => AlarmController());
    
    // Tambahkan semua controller lainnya di sini
  }
}
