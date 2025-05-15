// lib/features/bustracking/bustracking_binding.dart
import 'package:get/get.dart';

import '../features/bus_traking/controllers/bustraking_controller.dart';


class BusTrackingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusTrackingController>(() => BusTrackingController());
  }
}