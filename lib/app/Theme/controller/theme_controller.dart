import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final isDarkMode = false.obs;
  final box = GetStorage();

  bool  get isDark => isDarkMode.value;

  Future<void> loadTheme() async {
    isDarkMode.value = box.read('isDarkMode') ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    box.write('isDarkMode', isDarkMode.value);
  }
}
