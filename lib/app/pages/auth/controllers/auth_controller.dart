import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import '../../../widgets/loading_widget.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKeyRegisterPage = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRegisterKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  var isFormValid = false.obs;
  var isLoggedIn = false.obs; // Status login menggunakan GetStorage
  final box = GetStorage(); // GetStorage untuk menyimpan status
  // Menyimpan status apakah email sudah terdaftar atau belum
  var isEmailExist = false.obs;

  // Properti untuk menampung data pengguna
  String namaKtp = '';
  String noTelepon = '';
  String rt = '';
  String rw = '';
  String namaDesa = '';

  @override
  void onInit() {
    super.onInit();
    // Cek status login dari GetStorage
    isLoggedIn.value = box.read('isloggedin') ?? false;
  }

  void saveUser(String email, String password) {
    List<Map<String, dynamic>> users = box.read('users') ?? [];
    users.add({'email': email, 'password': password});
    box.write('users', users);

    // Simpan juga daftar email yang sudah terdaftar
    List<String> emails = box.read('registeredEmails') ?? [];
    emails.add(email);
    box.write('registeredEmails', emails);
  }

  // Fungsi untuk mengecek email dari GetStorage
  bool checkEmailExist(String email) {
    final box = GetStorage();
    final rawEmails = box.read('registeredEmails') ?? [];
    final List<String> emails = List<String>.from(
      rawEmails.whereType<String>(),
    );
    return emails.contains(email.trim());
  }

  bool isPasswordComplex(String password) {
    final regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return regex.hasMatch(password);
  }

  bool isEmailRegistered(String email) {
    final rawEmails = box.read('registeredEmails') ?? [];
    // Memastikan data yang dibaca adalah List<String>
    List<String> emails = List<String>.from(rawEmails.whereType<String>());
    return emails.contains(email);
  }

  bool isUserValid(String email, String password) {
    List<Map<String, dynamic>> users =
        box.read('users') ??
        []; // Tidak perlu cast langsung ke Map<String, String>

    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        return true;
      }
    }
    return false;
  }

  void login(String emailInput, String passwordInput) {
    if (isUserValid(emailInput, passwordInput)) {
      Get.snackbar(
        "Login Berhasil",
        "Selamat datang!",
        colorText: Colors.white,
      );

      box.write('isloggedin', true);
      isLoggedIn.value = true;

      Get.offAllNamed(AppRoutes.navbar);
    } else {
      Get.snackbar(
        "Login Gagal",
        "Email atau password salah",
        colorText: Colors.red,
      );
    }
  }

  void validateForm() {
    final isValid1 = formKeyRegisterKey.currentState?.validate() ?? false;
    final isValid2 = formKeyRegisterPage.currentState?.validate() ?? false;
    final isValid3 = formKeyLogin.currentState?.validate() ?? false;
    isFormValid.value = isValid1 || isValid2 || isValid3;
  }

  void submitForm(BuildContext context, String route) {
    final key1State = formKeyRegisterKey.currentState;
    final key2State = formKeyRegisterPage.currentState;
    final key3State = formKeyLogin.currentState;

    final isValid1 = key1State?.validate() ?? false;
    final isValid2 = key2State?.validate() ?? false;
    final isValid3 = key3State?.validate() ?? false;

    if (isValid1 || isValid2 || isValid3) {
      // Simulasi proses pendaftaran
      LoadingWidget.showLoading(
        context,
        message:
            isValid3
                ? "Memproses login..."
                : isValid2
                ? "Memproses verifikasi..."
                : "Memproses pendaftaran...",
      );

      Future.delayed(const Duration(seconds: 3), () {
        LoadingWidget.hideLoading(context);

        // Simulasi login/daftar dan update status di GetStorage
        if (isValid3) {
          box.write('isloggedin', true);
          isLoggedIn.value = true;
        } else {
          // Simulasi registrasi dan pindah ke halaman login
          box.write('isloggedin', false);
          isLoggedIn.value = false;
        }

        // Navigasi ke halaman sesuai status
        Get.offAllNamed(route);
      });
    }
  }

  void logout() {
    // Logout dengan menghapus status login dari GetStorage
    box.remove('isloggedin');
    isLoggedIn.value = false;
    Get.offAllNamed('/welcome'); // Kembali ke halaman welcome setelah logout
  }
}
