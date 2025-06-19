import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final AuthController controller = Get.find<AuthController>();
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.05,
          ),
          child: Form(
            key: controller.formKeyRegisterPage,
            onChanged: controller.validateForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Buat Akun",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("Silahkan isi data di bawah ini"),
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
                _buildInputField(
                  labelText: "Nama Sesuai KTP",
                  onChanged: (value) => controller.namaKtp = value,
                ),
                _buildInputField(
                  labelText: "No. Telepon",
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.noTelepon = value,
                ),
                _buildInputField(
                  labelText: "Rukun Tetangga (RT)",
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.rt = value,
                ),
                _buildInputField(
                  labelText: "Rukun Warga (RW)",
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.rw = value,
                ),
                _buildInputField(
                  labelText: "Nama Desa",
                  onChanged: (value) => controller.namaDesa = value,
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
                      if (controller.formKeyRegisterPage.currentState!
                          .validate()) {
                        storage.write('namaKtp', controller.namaKtp);
                        storage.write('noTelepon', controller.noTelepon);
                        storage.write('rt', controller.rt);
                        storage.write('rw', controller.rw);
                        storage.write('namaDesa', controller.namaDesa);
                        controller.submitForm(context, AppRoutes.register_key);
                      }
                    },
                    child: const Text("Daftar"),
                  ),
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
                        "login",
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

  Widget _buildInputField({
    required String labelText,
    bool obscure = false,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        cursorColor: Colors.green,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field ini tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}
