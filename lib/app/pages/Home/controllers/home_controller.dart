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
        title: "Instagram quietly limits ‘daily time limit’ option",
        author: "MacRumors",
        imageUrl: "https://picsum.photos/id/1000/960/540",
        postedOn: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      NewsModel(
        title: "Check your iPhone now: warning signs someone is spying on you",
        author: "New York Times",
        imageUrl: "https://picsum.photos/id/1001/960/540",
        postedOn: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        title:
            "Amazon’s incredibly popular Lost Ark MMO is ‘at capacity’ in central Europe",
        author: "MacRumors",
        imageUrl: "https://picsum.photos/id/1002/960/540",
        postedOn: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
      NewsModel(
        title:
            "Panasonic's 25-megapixel GH6 is the highest resolution Micro Four Thirds camera yet",
        author: "Polygon",
        imageUrl: "https://picsum.photos/id/1020/960/540",
        postedOn: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
      NewsModel(
        title: "Samsung Galaxy S22 Ultra charges strangely slowly",
        author: "TechRadar",
        imageUrl: "https://picsum.photos/id/1021/960/540",
        postedOn: DateTime.now().subtract(Duration(days: 1, hours: 3)),
      ),
    ];

    isLoading.value = false;
  }

  void onLabelTap(String label) {
    Get.snackbar("Label Dipilih", "Kamu memilih: $label");
  }
}
