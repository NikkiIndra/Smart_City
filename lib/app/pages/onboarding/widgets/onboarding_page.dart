import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../models/page_mode.dart';

final pages = [
  const PageData(
    icon: CupertinoIcons.device_phone_portrait,
    title: "Kemudahan hidup ada dalam genggaman kamu",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  const PageData(
    icon: CupertinoIcons.news,
    title: "Berani Melapor Untuk Kemajuan Bersama",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  const PageData(
    icon: CupertinoIcons.bus,
    title: "Ketahui Lokasi Bus saat ini",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  const PageData(
    icon: CupertinoIcons.lab_flask,
    title: "Apakah anda siap untuk melihat masa depan...",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
];

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder:
            (context) => Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.navigate_next,
                  size: screenWidth * 0.08,
                  color: Colors.white,
                ),
              ),
            ),
        itemCount: pages.length, // ✅ ini WAJIB agar tidak looping
        scaleFactor: 2,
        onFinish: () {
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.offAllNamed(AppRoutes.login);
          });
        },

        itemBuilder: (index) {
          final page = pages[index];
          return SafeArea(child: _Page(page: page));
        },
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({required this.page});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.textColor,
            ),
            child: Icon(
              page.icon,
              size: screenHeight * 0.1,
              color: page.bgColor,
            ),
          ),
          Text(
            page.title ?? "",
            style: TextStyle(
              color: page.textColor,
              fontSize: screenHeight * 0.015,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
