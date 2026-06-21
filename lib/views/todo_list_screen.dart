import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/todo_view_model.dart';

// Screen responsible for displaying todos fetched from the API.
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

    return Center(
      child: Text(
        'Todos count: ${viewModel.todos.length}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
