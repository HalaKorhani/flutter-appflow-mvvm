import 'package:flutter/material.dart';

import '../models/todo.dart';

// Screen responsible for displaying details of one selected todo.
class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: const Center(child: Text('Todo Details Screen')),
    );
  }
}
