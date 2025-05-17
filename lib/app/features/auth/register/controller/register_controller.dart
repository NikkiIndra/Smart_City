import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final box = GetStorage();

  // Cek apakah email sudah terdaftar
  bool isEmailRegistered(String email) {
    final rawEmails = box.read('registeredEmails') ?? [];
    final List<String> emails = List<String>.from(
      rawEmails.whereType<String>(),
    );
    return emails.contains(email.toLowerCase());
  }

  // Validasi kompleksitas password
  bool isPasswordComplex(String password) {
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    return hasLetter && hasNumber && hasSymbol;
  }

  // Proses registrasi
  void registerUser() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim().toLowerCase();
      final password = passwordController.text;

      final rawEmails = box.read('registeredEmails') ?? [];
      final List<String> emails = List<String>.from(
        rawEmails.whereType<String>(),
      );

      final rawUsers = box.read('users') ?? [];
      final List<Map<dynamic, dynamic>> users =
          rawUsers.map((e) => Map<String, String>.from(e)).toList();

      emails.add(email);
      users.add({'email': email, 'password': password});

      box.write('registeredEmails', emails);
      box.write('users', users);

      Get.snackbar('Sukses', 'Akun berhasil dibuat');
      Get.offAllNamed(AppRoutes.navbar);
    }
  }
}
