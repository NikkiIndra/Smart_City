import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/alarm_controller.dart';
import '../view/alarm_page.dart';

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});

  final controller = Get.put(AlarmController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AlarmPage());
  }
}
