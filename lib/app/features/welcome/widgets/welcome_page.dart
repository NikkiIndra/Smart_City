import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Tambahkan ini
import 'package:iofes_android_apps_smart_city/app/features/auth/login/screens/login_screen.dart';
import 'package:iofes_android_apps_smart_city/app/widgets/text_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi GetStorage
    final box = GetStorage();
    final heigh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 24.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/logo.jpeg",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              SizedBox(height: heigh * 0.02),
              const TemplateText(
                label: "Smart City",
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: heigh * 0.01),
              const TemplateText(
                label:
                    "Akses cepat informasi darurat, berita, dan layanan publik",
                fontSize: 16.0,
                fontWeight: FontWeight.w200,
              ),
            ],
          ),
          SizedBox(height: heigh * 0.4),
          ElevatedButton(
            onPressed: () {
              // Simpan status agar WelcomePage tidak ditampilkan lagi
              box.write('isfirsttime', false);

              // Arahkan ke halaman login
              Get.to(() => LoginScreen());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const TemplateText(
              label: "Jelajahi Sekarang",
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
