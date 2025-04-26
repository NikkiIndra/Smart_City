import 'package:flutter/material.dart';
import 'package:iofes_android_apps_smart_city/app/template_text.dart';

import '../widgets/main_page.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            children: [
              TemplateText(
                label: "Dashboard",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Icon(Icons.notifications, color: Colors.black),
              const Spacer(),
            ],
          ),
        ],
      ),
      body: MainPage(),
    );
  }
}
