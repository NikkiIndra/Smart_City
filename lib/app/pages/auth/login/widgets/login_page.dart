import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import '../../../../widgets/loading_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final box = GetStorage();

  bool isEmailRegistered(String email) {
    List<dynamic> users = box.read('users') ?? [];
    return users.any((user) => user['email'] == email.trim());
  }

  bool isUserValid(String email, String password) {
    List<dynamic> users = box.read('users') ?? [];
    return users.any((user) =>
        user['email'] == email.trim() && user['password'] == password.trim());
  }

  void loginUser(BuildContext context, String email, String password) {
    if (isUserValid(email, password)) {
      box.write('isloggedin', true);
      Get.snackbar(
        "Login Berhasil",
        "Selamat datang!",
        backgroundColor: Colors.transparent,
        colorText: Colors.white,
      );
      Get.offAllNamed(AppRoutes.navbar);
    } else {
      Get.snackbar(
        "Login Gagal",
        "Email atau password salah",
        backgroundColor: Colors.transparent,
        colorText: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.05,
          ),
          child: Form(
            key: formKeyLogin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Let's Goooo",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("Lihat berita terbaru dan terupdate"),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: Image.asset(
                    "assets/img/logo.jpeg",
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email harus diisi';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Format email tidak valid';
                    }
                    if (!isEmailRegistered(value)) {
                      return 'Email tidak terdaftar';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password harus diisi';
                    }
                    if (!isUserValid(emailController.text, value)) {
                      return 'Password tidak valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (formKeyLogin.currentState!.validate()) {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        LoadingWidget.showLoading(
                          context,
                          message: "Memverifikasi...",
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          LoadingWidget.hideLoading(context);
                          loginUser(context, email, password);
                        });
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF06D6A0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
