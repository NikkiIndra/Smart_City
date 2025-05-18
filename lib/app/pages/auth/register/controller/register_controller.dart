import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final isLoading = false.obs;
  final isTrue = false.obs;
  final box = GetStorage();

  bool isEmailExists(String email) {
    return box.read('email') == email.trim();
  }

  void registerUser() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar('Error', 'Semua field wajib diisi');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar('Error', 'Email tidak valid');
      return;
    }

    if (password != confirm) {
      Get.snackbar('Error', 'Password tidak sama');
      return;
    }

    if (isEmailExists(email)) {
      Get.snackbar('Error', 'Email sudah terdaftar');
      return;
    }

    box.write('email', email);
    box.write('password', password);

    Get.snackbar('Berhasil', 'Registrasi sukses, silakan login');
    Get.back(); // Kembali ke login
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
