import 'package:get/get.dart';
import '../bindings/laporan_binding.dart';
import '../features/laporan/screens/laporan_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.laporan,
      page: () => LaporanScreen(),
      binding: LaporanBinding(),
    ),
  ];
}
