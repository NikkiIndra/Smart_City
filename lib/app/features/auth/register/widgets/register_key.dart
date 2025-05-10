import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class RegisterKey extends StatefulWidget {
  RegisterKey({super.key});

  @override
  State<RegisterKey> createState() => _RegisterKeyState();
}

class _RegisterKeyState extends State<RegisterKey> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKeyRegisterKey,
          onChanged: controller.validateForm,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Email wajib diisi';
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Format email tidak valid';
                  }
                  if (controller.checkEmailExist(value)) {
                    return 'Email sudah terdaftar';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              // Pesan error jika email sudah terdaftar
              // Obx(() {
              //   if (controller.isEmailExist.value) {
              //     return Text(
              //       'Email sudah terdaftar',
              //       style: TextStyle(color: Colors.red, fontSize: 12),
              //     );
              //   }
              //   return SizedBox.shrink(); // Tidak menampilkan pesan jika email tidak ada
              // }),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Kata Sandi Baru",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Password wajib diisi';
                  if (value.length < 8) return 'Minimal 8 karakter';
                  if (!controller.isPasswordComplex(value)) {
                    return 'Password harus ada huruf, angka, dan simbol';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _confirmController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Tulis Ulang Kata Sandi",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Konfirmasi wajib diisi';
                  if (value != _passwordController.text)
                    return 'Kata sandi tidak sama';
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKeyRegisterKey.currentState!.validate()) {
                    final box = GetStorage();
                    final rawEmails = box.read('registeredEmails') ?? [];
                    final List<String> emails = List<String>.from(
                      rawEmails.whereType<String>(),
                    );

                    final List<dynamic> rawUsers = box.read('users') ?? [];
                    final List<Map<String, String>> users =
                        rawUsers
                            .map((e) => Map<String, String>.from(e as Map))
                            .toList();

                    // TRIM email sebelum disimpan
                    final email = _emailController.text.trim().toLowerCase();
                    final password = _confirmController.text;

                    emails.add(email.toLowerCase());
                    users.add({'email': email, 'password': password});

                    box.write('registeredEmails', emails);
                    box.write('users', users);

                    print(
                      box.read('registeredEmails'),
                    ); // Debug: tampilkan semua email tersimpan

                    controller.submitForm(context, AppRoutes.navbar);
                  }
                },

                child: Text("Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
