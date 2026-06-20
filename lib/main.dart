import 'package:flutter/material.dart';

void main() {
  runApp(const AppFlowMvvmApp());
}

class AppFlowMvvmApp extends StatelessWidget {
  const AppFlowMvvmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Flow MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Center(child: Text('App Flow MVVM'))),
    );
  }
}
