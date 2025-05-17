import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/controllers/report_controller.dart';

class ReportBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }
}