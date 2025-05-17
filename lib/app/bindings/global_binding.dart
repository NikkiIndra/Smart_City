import 'package:get/get.dart';

// Import semua controller yang dibutuhkan
import '../controller/navbar_controller.dart';
import '../pages/Home/controllers/home_controller.dart';
// ... dan seterusnya

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Semua controller yang akan digunakan di seluruh app
    Get.lazyPut<NavBarController>(() => NavBarController());
    Get.lazyPut<HomeController>(() => HomeController());

    // Tambahkan semua controller lainnya di sini
  }
}
