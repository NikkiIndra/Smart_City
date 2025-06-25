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
          key: authC.formKeyRegisterKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daftarkan Email",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),

              Image.asset("assets/img/logo.jpeg", height: 150),
              SizedBox(height: 20),
              TextFormField(
                controller: authC.emailController,
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
                  controller: authC.passwordController,
                  obscureText: authC.isTrue.value,
                  decoration: InputDecoration(
                    hintText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () => authC.isTrue.toggle(),
                      icon:
                          authC.isTrue.value
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
                  controller: authC.confirmController,
                  obscureText: authC.isTrue.value,
                  decoration: InputDecoration(
                    hintText: "Tulis Ulang Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () => authC.isTrue.toggle(),
                      icon:
                          authC.isTrue.value
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
                    if (value != authC.passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final email = authC.emailController.text.trim();
                  final password = authC.passwordController.text.trim();
                  if (authC.checkEmailExist(email)) {
                    Get.snackbar(
                      icon: Icon(CupertinoIcons.info_circle),
                      "Gagal",
                      "Email sudah terdaftar",
                      colorText: Colors.red,
                    );
                    return;
                  }

                  if (authC.formKeyRegisterKey.currentState!.validate()) {
                    authC.addUser(email, password);

                    Get.snackbar(
                      "Berhasil",
                      "Registrasi sukses, silakan login",
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 2),
                    );

                    Future.delayed(Duration(milliseconds: 500), () {
                      Get.offAllNamed(AppRoutes.login);
                    });
                  }
                },

                child: Text("daftar"),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "sudah punya akun?",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Color(0xFF06D6A0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
