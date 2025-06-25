import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import '../../../widgets/loading_widget.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKeyRegisterPage = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRegisterKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  var isFormValid = false.obs;
  var isLoggedIn = false.obs; // Status login menggunakan GetStorage
  final box = GetStorage(); // GetStorage untuk menyimpan status
  final isLoading = false.obs;
  final isTrue = true.obs;

  // Menyimpan status apakah email sudah terdaftar atau belum
  // var isEmailExist = false.obs;

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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }

  // membuat getter untuk konversi data dan mudah di akses
  List<Map<String, dynamic>> get allUsers {
    final raw = box.read('users') ?? [];
    return List<Map<String, dynamic>>.from(
      raw.map((e) => Map<String, dynamic>.from(e)),
    );
  }

  void addUser(String email, String password) {
    final rawUsers = box.read('users') ?? [];
    print("ISI USERS SAAT INI: $rawUsers");
    // Pastikan list berisi Map
  final List<Map<String, dynamic>> users =
    (rawUsers as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();


    final newUser = {
      'email': email.trim(),
      'password': password.trim(),
      'namaKtp': namaKtp,
      'noTelepon': noTelepon,
      'rt': rt,
      'rw': rw,
      'namaDesa': namaDesa,
    };

    users.add(newUser);
    box.write('users', users);
  }

  // Fungsi untuk mengecek email dari GetStorage
  // bool checkEmailExist(String email) {
  //   final box = GetStorage();
  //   final rawEmails = box.read('registeredEmails') ?? [];
  //   final List<String> emails = List<String>.from(
  //     rawEmails.whereType<String>(),
  //   );
  //   return emails.contains(email.trim());
  // }

  // bool checkEmailExist(String email) {
  //   final users = box.read('users') ?? [];
  //   return users.any((user) => user['email'] == email.trim());
  // }
  bool checkEmailExist(String email) {
    return allUsers.any((user) => user['email'] == email.trim());
  }

  Map<String, dynamic>? getUserByEmail(String email) {
    return allUsers.firstWhereOrNull((user) => user['email'] == email.trim());
  }

  // Map<String, dynamic>? getUserByEmail(String email) {
  //   final users = box.read('users') ?? [];
  //   return users.firstWhereOrNull((user) => user['email'] == email);
  // }
  // bool isPasswordComplex(String password) {
  //   final regex = RegExp(
  //     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  //   );
  //   return regex.hasMatch(password);
  // }

  // bool isUserValid(String email, String password) {
  //   List<Map<String, dynamic>> users =
  //       box.read('users') ??
  //       [];

  //   for (var user in users) {
  //     if (user['email'] == email && user['password'] == password) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  bool isUserValid(String email, String password) {
    final users = box.read('users') ?? [];
    return users.any(
      (user) => user['email'] == email && user['password'] == password,
    );
  }

  void login(String emailInput, String passwordInput) {
    if (isUserValid(emailInput, passwordInput)) {
      final user = getUserByEmail(emailInput);
      if (user != null) {
        box.write('isloggedin', true);
        box.write('currentUser', user);
        isLoggedIn.value = true;

        Get.snackbar('Login Berhasil', 'Selamat datang ${user['namaKtp']}!');
        Get.offAllNamed(AppRoutes.navbar);
      } else {
        Get.snackbar(
          'Login Gagal',
          'Email atau password salah',
          colorText: Colors.red,
        );
      }
    }
  }

  void validateForm() {
    final isValiEmail = formKeyRegisterKey.currentState?.validate() ?? false;
    final isvalidRegister =
        formKeyRegisterPage.currentState?.validate() ?? false;
    final isValidLogin = formKeyLogin.currentState?.validate() ?? false;
    isFormValid.value = isValiEmail || isvalidRegister || isValidLogin;
  }

  void submitForm(BuildContext context, String route) {
    final isValiEmail = formKeyRegisterKey.currentState?.validate() ?? false;
    final isvalidRegister =
        formKeyRegisterPage.currentState?.validate() ?? false;
    final isValidLogin = formKeyLogin.currentState?.validate() ?? false;

    if (isValiEmail || isvalidRegister || isValidLogin) {
      // Simulasi proses pendaftaran
      LoadingWidget.showLoading(
        context,
        message:
            isValidLogin
                ? "Memproses login..."
                : isvalidRegister
                ? "Memproses verifikasi..."
                : "Memproses pendaftaran...",
      );

      Future.delayed(const Duration(seconds: 3), () {
        LoadingWidget.hideLoading(context);

        // Simulasi login/daftar dan update status di GetStorage
        if (isValidLogin) {
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
    box.remove('isloggedin');
    box.remove('currentUser');
    isLoggedIn.value = false;
    Get.offAllNamed('/welcome');
  }

  // ✅ Akses user yang sedang login
  Map<String, dynamic>? get currentUser => box.read('currentUser');
}
