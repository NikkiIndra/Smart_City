import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initApp() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isfirsttime') ?? true;

    await Future.delayed(const Duration(seconds: 1)); // simulasi loading

    if (isFirstTime) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // lanjut ke welcome/login
      _initApp(); // panggil langsung saat build
    });

    return const Scaffold(
      backgroundColor: Color(0xFF50C9CE),
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFF2E382E)),
      ),
    );
  }
}
