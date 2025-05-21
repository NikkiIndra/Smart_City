import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/pages/auth/register/controller/register_controller.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';

import '../../controllers/auth_controller.dart';

class RegisterKey extends StatelessWidget {
  RegisterKey({super.key});
  final AuthController authC = Get.find<AuthController>();
  final RegisterController controller = Get.find();
  final storage = GetStorage(); // ✅ Tambahan

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: screenHeight * 0.05,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Let's Goooo",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/img/logo.jpeg", height: 150),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final email = value?.trim().toLowerCase() ?? '';
                  if (email.isEmpty) return 'Email wajib diisi';
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.isTrue.value,
                  decoration: InputDecoration(
                    hintText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () => controller.isTrue.toggle(),
                      icon:
                          controller.isTrue.value
                              ? Icon(CupertinoIcons.eye_slash_fill)
                              : Icon(CupertinoIcons.eye_fill),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 8) return 'Minimal 8 karakter';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 12),

              Obx(
                () => TextFormField(
                  controller: controller.confirmController,
                  obscureText: controller.isTrue.value,
                  decoration: InputDecoration(
                    hintText: "Tulis Ulang Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () => controller.isTrue.toggle(),
                      icon:
                          controller.isTrue.value
                              ? Icon(CupertinoIcons.eye_slash_fill)
                              : Icon(CupertinoIcons.eye_fill),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi wajib diisi';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final email = controller.emailController.text.trim();
                  final password = controller.passwordController.text.trim();
                  if (controller.isEmailUsed(email)) {
                    Get.snackbar(
                      icon: Icon(CupertinoIcons.info_circle),
                      "Gagal",
                      "Email sudah terdaftar",
                      colorText: Colors.red,
                    );
                    return;
                  }

                  if (controller.formKey.currentState!.validate()) {
                    controller.addUser(email, password);

                    // Snackbar sukses
                    Get.snackbar(
                      "Berhasil",
                      "Registrasi sukses, silakan login",
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 2),
                    );

                    // Navigasi ke login setelah delay sedikit biar snackbar sempat muncul
                    Future.delayed(Duration(milliseconds: 500), () {
                      Get.offAllNamed(
                        AppRoutes.login,
                      ); // arahkan ke halaman login
                    });
                  }
                },

                child: Text("daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
