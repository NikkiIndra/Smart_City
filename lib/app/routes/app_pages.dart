import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/bindings/global_binding.dart';
import 'package:iofes_android_apps_smart_city/app/bindings/report_binding.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/screens/alarm_screen.dart';
import 'package:iofes_android_apps_smart_city/app/features/alarm/view/alarm_page.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/register/screens/register_screen.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/register/view/register_key.dart';
import 'package:iofes_android_apps_smart_city/app/features/report/view/report_view.dart';
import 'package:iofes_android_apps_smart_city/app/pages/profile/view/profile_page.dart';
import 'package:iofes_android_apps_smart_city/app/pages/settings/widgets/setting_page.dart';
import '../bindings/bus_tracking_bindings.dart';
import '../bindings/register_binding.dart';
import '../pages/auth/login/screens/login_screen.dart';
import '../features/bus_traking/view/map_screen.dart';
import '../pages/dashboard/view/dashboard_page.dart';
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
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      binding: GlobalBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.register_key,
      page: () => RegisterKey(),
      binding: RegisterBindins(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.alarm,
      page: () => AlarmScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.navbar,
      page: () => NavBar(),
      binding: GlobalBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.bus_tracking, // Gunakan yang sudah diperbaiki
      page: () => MapScreen(),
      binding: BusTrackingBinding(), // Gunakan binding spesifik
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => ReportScreen(),
      binding: ReportBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => SettingsPage(),
      binding: GlobalBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.alarm,
      page: () => AlarmPage(),
      binding: GlobalBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: GlobalBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(seconds: 1),
    ),
  ];
}
