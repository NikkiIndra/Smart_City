import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/login/widgets/login_page.dart';
import '../../../routes/app_routes.dart';
import '../models/page_mode.dart';

final pages = [
  const PageData(
    icon: CupertinoIcons.device_phone_portrait,
    title: "Kemudahan hidup ada dalam genggaman kamu",
    bgColor: Color(0xff3b1791),
    textColor: Colors.white,
  ),
  const PageData(
    icon: CupertinoIcons.news,
    title: "Berani Melapor Untuk Kemajuan Bersama",
    bgColor: Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
  const PageData(
    icon: CupertinoIcons.bus,
    title: "Ketahui Lokasi Bus saat ini",
    bgColor: Color(0xff3b1791),
    textColor: Color(0xffffffff),
  ),
  const PageData(
    icon: CupertinoIcons.lab_flask,
    title: "Apakah anda siap untuk melihat masa depan...",
    bgColor: Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
];

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

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
              child: Icon(Icons.navigate_next, size: screenWidth * 0.08),
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

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: page.textColor,
          ),
          child: Icon(page.icon, size: screenHeight * 0.1, color: page.bgColor),
        ),
        Text(
          page.title ?? "",
          style: TextStyle(
            color: page.textColor,
            fontSize: screenHeight * 0.035,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
