import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../controller/navbar_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: controller.pages[controller.currentIndex.value],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            gap: 8,
            selectedIndex: controller.currentIndex.value,
            onTabChange: controller.changeTab,
            iconSize: 24,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            color: Theme.of(context).iconTheme.color,
            activeColor: Colors.teal,
            tabs: const [
              GButton(icon: Icons.settings, text: 'Pengaturan'),
              GButton(icon: Icons.home, text: 'Beranda'),
              GButton(icon: Icons.person, text: 'Saya'),
            ],
          ),
        ),
      ),
    );
  }
}
