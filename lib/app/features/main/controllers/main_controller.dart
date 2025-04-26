import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../report/screens/report_screen.dart';

class MainController extends GetxController {
  final dateController = TextEditingController();

  // Controller untuk mengelola state dan logika dari MainPage
  // Misalnya, mengelola tab yang aktif, data yang ditampilkan, dll.

  var currentIndex = 0.obs; // Menyimpan index tab yang aktif

  void ListPage(){
    ReportScreen();
    // ContactScreen();
    // DangerScreen();
    // BusScreen();
  }
}