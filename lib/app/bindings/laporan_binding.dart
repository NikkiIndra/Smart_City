import 'package:get/get.dart';

import '../features/laporan/controllers/laporan_controller.dart';

class LaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanController>(() => LaporanController());
  }
}
