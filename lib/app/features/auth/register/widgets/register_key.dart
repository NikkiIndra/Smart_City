import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/auth/register/controller/register_controller.dart';

class RegisterKey extends StatelessWidget {
  RegisterKey({super.key});

  final RegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "E-Mail",
                    prefixIcon: Icon(Icons.email),
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
                    if (controller.isEmailRegistered(email)) {
                      return 'Email sudah terdaftar';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Kata Sandi Baru",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 8) return 'Minimal 8 karakter';
                    if (!controller.isPasswordComplex(value)) {
                      return 'Harus ada huruf, angka, dan simbol';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: controller.confirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Tulis Ulang Kata Sandi",
                    prefixIcon: Icon(Icons.lock_outline),
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
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.registerUser,
                  child: Text("Daftar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
