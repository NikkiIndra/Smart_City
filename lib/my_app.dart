import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/Theme/controller/theme_controller.dart';
import 'app/Theme/themes.dart';
import 'app/bindings/global_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/splesh_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SmartCity",
      initialBinding: GlobalBindings(),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(), // ✅ Panggil SplashScreen dulu, dia yang arahkan
      getPages: AppPages.pages,
    );
  }
}
