// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'app/Theme/controller/theme_controller.dart';
// import 'app/Theme/themes.dart';
// import 'app/bindings/global_binding.dart';
// import 'app/routes/app_pages.dart';
// import 'app/routes/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(ThemeController());
//   runApp(MyApp(isFirstTime: isFirstTime));
// }


// class MyApp extends StatelessWidget {
//   final bool isFirstTime;
//   const MyApp({super.key, required this.isFirstTime});

//   @override
//   Widget build(BuildContext context) {
//     final themeController = Get.find<ThemeController>();

//     return Obx(() => GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: "SmartCity",
//           initialBinding: GlobalBindings(),
//           theme: AppThemes.lightTheme,
//           darkTheme: AppThemes.darkTheme,
//           themeMode: themeController.isDarkMode.value
//               ? ThemeMode.dark
//               : ThemeMode.light,
//           initialRoute: isFirstTime ? AppRoutes.welcome : AppRoutes.login,
//           getPages: AppPages.pages,
//           home: SplashScreen(),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/Theme/controller/theme_controller.dart';
import 'package:iofes_android_apps_smart_city/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();

  final box = GetStorage();
  final isFirstTime = box.read('isfirsttime') ?? true;
  final isLoggedIn = box.read('is_logged_in') ?? false;
  final themeController = Get.put(ThemeController());
  await themeController.loadTheme(); // tidak perlu ubah jika dalam controller pakai GetStorage

  runApp(MyApp(isFirstTime: isFirstTime, isLoggedIn: isLoggedIn));
}
