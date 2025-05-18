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

  bool isEmailUsed(String email) {
    return storage.read('email') == email.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    if (isEmailUsed(email)) {
                      return 'Email sudah terdaftar';
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
                      hintText: "Kata Sandi Baru",
                      suffixIcon: IconButton(
                        onPressed: () => controller.isTrue.toggle(),
                        icon: controller.isTrue.value
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
                        icon: controller.isTrue.value
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
                    if (controller.formKey.currentState!.validate()) {
                      final email = controller.emailController.text.trim();
                      final password = controller.passwordController.text.trim();

                      // ✅ Simpan ke GetStorage
                      storage.write('email', email);
                      storage.write('password', password);

                      // ✅ Navigasi ke route setelah daftar
                      authC.submitForm(context, AppRoutes.register_key);
                    }
                  },
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
