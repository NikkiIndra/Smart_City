import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

   void _checkFirstTime() async {
    await Future.delayed(const Duration(seconds: 2)); // simulasi loading
    bool isFirstTime = box.read('isfirsttime') ?? true;
    bool isLoggedIn = box.read('is_logged_in') ?? false;

    if (isFirstTime) {
      box.write('isfirsttime', false);
      Get.offAllNamed(AppRoutes.onboarding); // arahkan ke onboarding
    } else {
      if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.navbar); // arahkan ke navbar
      } else {
        Get.offAllNamed(AppRoutes.login); // arahkan ke login
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFF2E382E)),
      ),
    );
  }
}
