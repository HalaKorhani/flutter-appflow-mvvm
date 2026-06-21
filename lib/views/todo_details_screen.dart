import 'package:flutter/material.dart';

import '../models/todo.dart';

// Screen responsible for displaying details of one selected todo.
class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${todo.id}'),
            Text('User ID: ${todo.userId}'),
            Text('Title: ${todo.title}'),
            Text('Completed: ${todo.completed}'),
          ],
        ),
      ),
    );
  }
}
