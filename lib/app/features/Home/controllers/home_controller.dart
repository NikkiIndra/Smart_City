import 'package:get/get.dart';
import '../models/news_item.dart';

class HomeController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var isLoading = true.obs;

  List<String> labels = [
    "kontak penting",
    "Lapor Insiden",
    "peringatan Bahaya",
    "Traking Bus",
  ];

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  Future<void> loadNews() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simulasi pemuatan data

    newsList.value = [
      NewsModel(
        title: "Jalan Desa Diperbaiki",
        description: "Pemerintah desa mulai memperbaiki jalan utama...",
        time: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      NewsModel(
        title: "Posyandu Bulan Ini",
        description: "Posyandu balita akan diadakan hari Jumat...",
        time: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        title: "Pesta Rakyat 17 Agustus",
        description: "Panitia telah menyiapkan lomba dan panggung hiburan...",
        time: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
    ];

    isLoading.value = false;
  }

  void onLabelTap(String label) {
    Get.snackbar("Label Dipilih", "Kamu memilih: $label");
  }
}
