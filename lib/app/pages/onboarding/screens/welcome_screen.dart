import 'package:flutter/material.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const OnboardingPage(), // Tidak perlu Center jika WelcomePage sudah diatur dengan benar
    );
  }
}
