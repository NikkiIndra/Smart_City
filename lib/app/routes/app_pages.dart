import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/bindings/report_binding.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/screens/alarm_screen.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/register/screens/register_screen.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/register/widgets/register_key.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/view/report_view.dart';
import '../bindings/bus_tracking_bindings.dart';
import '../bindings/register_binding.dart';
import '../pages/auth/login/screens/login_screen.dart';
import '../features/bus_traking/view/map_screen.dart';
import '../pages/onboarding/screens/welcome_screen.dart';
import '../widgets/bottom_bar.dart';
import 'app_routes.dart';

// Ini seperti "daftar isi" halaman di aplikasi kamu.

// Setiap route dikaitkan dengan halaman (page) dan controller melalui binding.
// Binding ini memastikan bahwa controller yang tepat diinisialisasi ketika halaman dibuka.
// Dengan cara ini, kamu bisa mengelola dependensi dengan lebih baik dan menjaga kode tetap terorganisir.

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.alarm,
      page: () => AlarmScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.navbar,
      page: () => NavBar(),
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 2),
    ),
    GetPage(
      name: AppRoutes.register_key,
      page: () => RegisterKey(),
      binding: RegisterBindins(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.bus_tracking, // Gunakan yang sudah diperbaiki
      page: () => const MapScreen(),
      binding: BusTrackingBinding(), // Gunakan binding spesifik
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => ReportScreen(),
      binding: ReportBinding(),
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 1),
    ),
  ];
}
