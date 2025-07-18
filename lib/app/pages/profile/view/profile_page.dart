import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/pages/profile/controllers/profile_controller.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/loading_widget.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final auth = Get.find<AuthController>();
  ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {

  final user = auth.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  "assets/img/pp.png",
                ), // Pastikan file ini ada
              ),
            ),
            const SizedBox(height: 15),
            // Nama dan Email
            Text(
              user?['namaKtp'] ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user?['email'] ?? '',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Tombol Edit Profil
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi edit
                },
                child: const Text("Edit Profil"),
              ),
            ),
            const SizedBox(height: 30),

            // Menu lainnya
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Ubah Password"),
              onTap: () {
                // Aksi ubah password
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Pengaturan"),
              onTap: () {
                // Aksi ke halaman pengaturan
              },
            ),
            GestureDetector(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text("Keluar"),
              ),
              onTap: () {
                LoadingWidget.showLoading(
                  context,
                  message: "Keluar dari aplikasi...",
                );
                Future.delayed(const Duration(seconds: 3), () {
                  LoadingWidget.hideLoading(context);
                  Get.offAllNamed(AppRoutes.login);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
