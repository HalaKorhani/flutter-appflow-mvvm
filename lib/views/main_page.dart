import 'package:flutter/material.dart';

// Temporary main page.
// Later we will add drawer navigation and connect all screens.
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Main Page')));
  }
}
