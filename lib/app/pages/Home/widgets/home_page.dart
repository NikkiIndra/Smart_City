import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/pages/Home/controllers/home_controller.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';

import '../../../Theme/controller/theme_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // ini saya rubah hari ini 03/05/2025
  // final HomeController controller = Get.put<HomeController>(HomeController());
  final HomeController controller = Get.find();
  final isDark = Get.find<ThemeController>().isDark;
  // Daftar ikon untuk fitur
  final icons = [
    Icons.contact_phone_outlined,
    Icons.report_problem_outlined,
    Icons.warning_amber_outlined,
    Icons.directions_bus_outlined,
  ];

  final labels = [
    "kontak penting",
    "Lapor Insiden",
    "peringatan Bahaya",
    "Traking Bus",
  ];

  final feature = [
    null, // Untuk kontak penting
    AppRoutes.report,
    AppRoutes.report,
    AppRoutes.bus_tracking, // Gunakan route yang sudah diperbaiki
  ];

  void handleFeatureTap(int index) {
    if (index == 0) {
      Get.snackbar('Info', 'Fitur kontak penting belum tersedia');
      return;
    }

    Get.toNamed(feature[index]!); // Gunakan ! karena kita yakin tidak null
  }
  // Perbaiki daftar navigasi berdasarkan index
  // void handleFeatureTap(int index) {
  //   final target = feature[index];
  //   if (target is String) {
  //     Get.toNamed(target); // ✅ akan jalankan binding otomatis
  //   } else if (target is Widget) {
  //     Get.to(() => target);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/img/pp.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TemplateText(
                        label: "Hello, David",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 5),
                      TemplateText(
                        label: "saya harap kamu senang hari ini",
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // JUDUL FITUR
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            sliver: SliverToBoxAdapter(
              child: const TemplateText(
                label: "fitur penyelamat kamu",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // GRID FITUR (INTERAKTIF)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return GestureDetector(
                  onTap: () => handleFeatureTap(index),
                  child: Container(
                    height: 136,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index], size: 30),
                          const SizedBox(height: 8),
                          TemplateText(
                            label: labels[index],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: labels.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            ),
          ),

          // JUDUL INFORMASI TERKINI
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
            sliver: SliverToBoxAdapter(
              child: const TemplateText(
                label: "informasi desa terkini",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // BERITA TERKINI DENGAN LOADING
          Obx(() {
            if (controller.isLoading.value) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.newsList[index];

                  return Container(
                    height: 136,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${item.author} · ${item.formattedTime}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    [
                                      Icons.bookmark_border_rounded,
                                      Icons.share,
                                      Icons.more_vert,
                                    ].map((e) {
                                      return InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                          ),
                                          child: Icon(e, size: 16),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.imageUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: controller.newsList.length),
              ),
            );
          }),
        ],
      ),
    );
  }
}
