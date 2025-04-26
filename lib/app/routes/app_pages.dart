import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/bindings/laporan_binding.dart';
import 'package:iofes_android_apps_smart_city/app/features/auth/register/screens/register_screen.dart';
import 'package:iofes_android_apps_smart_city/app/features/main/screens/main_screen.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/screens/report_screen.dart';
import '../features/auth/login/screens/login_screen.dart';
import '../features/welcome/screens/welcome_screen.dart';
import 'app_routes.dart';

// Ini seperti "daftar isi" halaman di aplikasi kamu.

// Setiap route dikaitkan dengan halaman (page) dan controller melalui binding.
// Binding ini memastikan bahwa controller yang tepat diinisialisasi ketika halaman dibuka.
// Dengan cara ini, kamu bisa mengelola dependensi dengan lebih baik dan menjaga kode tetap terorganisir.

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.welcome, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.main_page, page: () => MainScreen()),

    GetPage(
      name: AppRoutes.report,
      page: () => ReportScreen(),
      binding: ReportBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.contac,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.alarm,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.bus_traking,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.settings,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.signout,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.dashboard,
    //   page: () => LaporanScreen(),
    //   binding: LaporanBinding(),
    // ),
  ];
}
