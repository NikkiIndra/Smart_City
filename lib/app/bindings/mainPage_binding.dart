import 'package:get/get.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    // get method ini akan dipanggil saat halaman ini diakses
    // dan akan menginisialisasi controller MainPageController
    // Get.lazyPut<MainPageController>(() => MainPageController());
  }
}