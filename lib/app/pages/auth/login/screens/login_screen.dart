import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/controllers/auth_controller.dart';
import '../widgets/login_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginPage());
  }
}
