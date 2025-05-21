import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/Theme/controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: CupertinoIcons.moon,
                    trailing: Obx(
                      () => CupertinoSwitch(
                        value: themeController.isDarkMode.value,
                        onChanged: (value) {
                          themeController.toggleTheme();
                        },
                      ),
                    ),
                  ),

                  const _CustomListTile(
                    title: "Notifications",
                    icon: Icons.notifications_none_rounded,
                  ),
                  _CustomListTile(
                    title: "Izinkan Kamera",
                    icon: Icons.camera_alt_outlined,
                    trailing: Obx(
                      () => CupertinoSwitch(
                        value: controller.cameraAllowed.value,
                        onChanged: (_) {
                          controller.openSettingsAndRefresh();
                        },
                      ),
                    ),
                  ),
                  _CustomListTile(
                    title: "Izinkan Lokasi",
                    icon: Icons.location_on_outlined,
                    trailing: Obx(
                      () => CupertinoSwitch(
                        value: controller.locationAllowed.value,
                        onChanged: (_) {
                          controller.openSettingsAndRefresh();
                        },
                      ),
                    ),
                  ),

                  const Divider(),
                  const _SingleSection(
                    title: "Organization",
                    children: [
                      _CustomListTile(
                        title: "Profile",
                        icon: Icons.person_outline_rounded,
                      ),
                      _CustomListTile(
                        title: "Messaging",
                        icon: Icons.message_outlined,
                      ),
                      _CustomListTile(
                        title: "Calling",
                        icon: Icons.phone_outlined,
                      ),
                      _CustomListTile(
                        title: "People",
                        icon: Icons.contacts_outlined,
                      ),
                      _CustomListTile(
                        title: "Calendar",
                        icon: Icons.calendar_today_rounded,
                      ),
                    ],
                  ),
                  const Divider(),
                  const _SingleSection(
                    children: [
                      _CustomListTile(
                        title: "Help & Feedback",
                        icon: Icons.help_outline_rounded,
                      ),
                      _CustomListTile(
                        title: "About",
                        icon: Icons.info_outline_rounded,
                      ),
                      _CustomListTile(
                        title: "Sign out",
                        icon: Icons.exit_to_app_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(children: children),
      ],
    );
  }
}
