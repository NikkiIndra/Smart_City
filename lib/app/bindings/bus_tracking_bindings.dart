import '../features/bus_traking/controllers/bustraking_controller.dart';
import 'package:get/get.dart';
class BusTrackingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusTrackingController>(() => BusTrackingController());
    // Tambahkan dependency lain yang diperlukan khusus untuk bus tracking
  }
}