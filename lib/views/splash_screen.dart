import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_view_model.dart';
import 'login_screen.dart';
import 'main_page.dart';

// Splash screen with Lottie animation and Remember Me navigation.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Small delay so the Lottie animation is visible while data initializes.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authViewModel = context.read<AuthViewModel>();
    await authViewModel.initialize();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            authViewModel.isLoggedIn ? const MainPage() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/splash.json',
              width: 190,
              height: 190,
              repeat: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Initializing App...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
