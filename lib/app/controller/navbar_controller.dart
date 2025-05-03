import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/Home/widgets/home_page.dart';
import 'package:iofes_android_apps_smart_city/app/features/profile/widgets/profile_page.dart';
import 'package:iofes_android_apps_smart_city/app/features/settings/widgets/setting_page.dart';

class NavBarController extends GetxController {
  // Controller untuk mengelola state dan logika aplikasi
  final RxInt currentIndex = 1.obs;

  // Membuat halaman dinamis berdasarkan indeks
  List<Widget> get pages => [
        const SettingsPage(),
        HomePage(),
        const ProfilePage(),
      ];

  List<String> get titles => [
        'Home',
        'Profile',
        'Settings',
      ];

  // Method untuk mengubah tab
  void changeTab(int index) {
    currentIndex.value = index;
  }
}
