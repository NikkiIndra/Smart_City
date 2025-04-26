import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../template_text.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TemplateText(
                label: "Buat Akun",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              TemplateText(
                label: "Silahkan isi data di bawah ini",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(height: 24),
              Center(
                child: Image.asset("img/logo.jpeg", width: 100, height: 100),
              ),
              SizedBox(height: 20),
              _buildInputField(Icons.person, "Nama Lengkap"),
              _buildInputField(Icons.email, "Email"),
              _buildInputField(Icons.lock, "Password", obscure: true),
              _buildInputField(
                Icons.lock,
                "tulis ulang password",
                obscure: true,
              ),
              _buildInputField(Icons.phone, "No.telepone"),
              _buildInputField(Icons.badge, "nama asli ktp"),
              _buildInputField(Icons.home, "Rukun Tetangga(RT)"),
              _buildInputField(Icons.home, "Rukun Warga(RW)"),
              _buildInputField(Icons.location_city, "nama desa"),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/report');
                    // Navigator.push(
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                  child: TemplateText(
                    label: "Daftar",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat input field dengan ikon
  Widget _buildInputField(IconData icon, String hint, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
