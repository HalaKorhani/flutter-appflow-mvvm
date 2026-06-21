import 'package:flutter/material.dart';

import '../models/todo.dart';

// Screen responsible for displaying details of one selected todo.
class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailsScreen({super.key, required this.todo});

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('ID:', todo.id.toString()),
                _detailRow('User ID:', todo.userId.toString()),
                _detailRow('Title:', todo.title),
                _detailRow('Completed:', todo.completed.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
