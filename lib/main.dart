import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/Theme/controller/theme_controller.dart';
import 'package:iofes_android_apps_smart_city/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final themeController = Get.put(ThemeController());
  await themeController.loadTheme();

  runApp(const MyApp());
}
