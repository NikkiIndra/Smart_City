import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';

import 'app/Theme/controller/theme_controller.dart';
import 'app/Theme/themes.dart';
import 'app/bindings/global_binding.dart';
import 'app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

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
      initialRoute: isFirstTime ? AppRoutes.welcome : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}

