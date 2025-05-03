import 'package:get/get.dart';
import '../features/alarm/controllers/alarm_controller.dart';

class AlarmBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlarmController>(() => AlarmController());
  }
}