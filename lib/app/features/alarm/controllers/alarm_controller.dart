import 'package:get/get.dart';

class AlarmController extends GetxController {
  // Add your controller logic here
  // For example, you can define variables and methods to manage alarms
  var alarms = <String>[].obs; // Example: List of alarm names

  void addAlarm(String alarmName) {
    alarms.add(alarmName);
  }

}