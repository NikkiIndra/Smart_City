import 'package:flutter/material.dart';
import '../widgets/welcome_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const WelcomePage(), // Tidak perlu Center jika WelcomePage sudah diatur dengan benar
    );
  }
}
