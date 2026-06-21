import 'package:flutter/material.dart';

// Screen responsible for showing network monitoring feature.
class NetworkServiceScreen extends StatelessWidget {
  const NetworkServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          'Network Service Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
