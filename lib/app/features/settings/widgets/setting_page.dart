import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/Theme/controller/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              children: [
                // Dark Mode toggle
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.dark_mode_outlined, size: 28),
                  title: const Text('Dark Mode'),
                  trailing: Obx(
                    () => Switch.adaptive(
                      value: themeController.isDarkMode.value,
                      onChanged: (_) => themeController.toggleTheme(),
                    ),
                  ),
                ),
                const Divider(height: 32),

                // Other settings items
                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifikasi',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Privacy',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  label: 'About Account',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.headset_mic_outlined,
                  label: 'Help',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, size: 28),
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
