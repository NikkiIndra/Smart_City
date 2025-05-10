import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iofes_android_apps_smart_city/app/routes/app_routes.dart';
import '../../../../widgets/text_widget.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final AuthController controller = Get.find<AuthController>();
  final GetStorage storage =
      GetStorage(); // Menggunakan GetStorage untuk menyimpan data

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKeyRegisterPage,
            onChanged: controller.validateForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TemplateText(
                  label: "Buat Akun",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                TemplateText(
                  label: "Silahkan isi data di bawah ini",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    "assets/img/logo.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  Icons.badge,
                  "Nama Sesuai KTP",
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.namaKtp =
                        value; // Menyimpan nama KTP di controller
                  },
                ),
                _buildInputField(
                  Icons.phone,
                  "No. Telepon",
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    controller.noTelepon =
                        value; // Menyimpan no telepon di controller
                  },
                ),
                _buildInputField(
                  Icons.home,
                  "Rukun Tetangga (RT)",
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    controller.rt = value; // Menyimpan RT di controller
                  },
                ),
                _buildInputField(
                  Icons.home,
                  "Rukun Warga (RW)",
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    controller.rw = value; // Menyimpan RW di controller
                  },
                ),
                _buildInputField(
                  Icons.location_city,
                  "Nama Desa",
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    controller.namaDesa =
                        value; // Menyimpan nama desa di controller
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKeyRegisterPage.currentState!
                          .validate()) {
                        // Menyimpan data di GetStorage sebelum lanjut
                        storage.write('namaKtp', controller.namaKtp);
                        storage.write('noTelepon', controller.noTelepon);
                        storage.write('rt', controller.rt);
                        storage.write('rw', controller.rw);
                        storage.write('namaDesa', controller.namaDesa);

                        // Mengirim data ke server IoT atau langkah selanjutnya
                        controller.submitForm(context, AppRoutes.register_key);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: TemplateText(
                      label: "Daftar",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat input field dengan ikon
  Widget _buildInputField(
    IconData icon,
    String hint, {
    bool obscure = false,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.greenAccent),
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,

        cursorColor: Colors.greenAccent,
        onChanged: onChanged, // Menangani perubahan input
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
