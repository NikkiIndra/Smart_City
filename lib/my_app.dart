import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/Theme/controller/theme_controller.dart';
import 'app/Theme/themes.dart';
import 'app/bindings/global_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLoggedIn;
  const MyApp({
    super.key,
    required this.isFirstTime,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    String initialRoute;
    if (isFirstTime) {
      initialRoute = AppRoutes.welcome;
    } else if (isLoggedIn) {
      initialRoute = AppRoutes.navbar; // atau dashboard page Anda
    } else {
      initialRoute = AppRoutes.login;
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SmartCity",
      initialBinding: GlobalBindings(),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    );
  }
}
