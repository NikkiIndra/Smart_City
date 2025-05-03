import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/Home/controllers/home_controller.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // ini saya rubah hari ini 03/05/2025
  final HomeController controller = Get.put<HomeController>(HomeController());

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

  void handleFeatureTap(int index) {
    print("Tapped: ${labels[index]}");
    // Misalnya Get.toNamed('/kontak');
    Get.toNamed(
      AppRoutes.alarm,
      arguments: {"title": labels[index], "icon": icons[index]},
    );
  }

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
                  child: Card(
                    color: Colors.teal[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index], size: 30, color: Colors.white),
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
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TemplateText(
                            label: item.title,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5),
                          TemplateText(
                            label: item.description,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.thumb_up_alt_outlined, size: 14),
                                  SizedBox(width: 5),
                                  TemplateText(
                                    label: "120",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              TemplateText(
                                label: item.formattedTime,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ],
                      ),
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
