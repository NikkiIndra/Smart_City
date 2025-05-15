import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/controllers/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    // Semua controller yang akan digunakan di seluruh app
    Get.lazyPut<ReportController>(() => ReportController());
    // Tambahkan semua controller lainnya di sini
  }
}
