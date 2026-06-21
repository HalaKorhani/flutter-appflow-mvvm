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
  void initState() {
    super.initState();

    // Load API data after the widget appears.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<TodoViewModel>();

      if (viewModel.todos.isEmpty) {
        viewModel.loadTodos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

    if (viewModel.isLoading && viewModel.todos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Text(
        'Todos count: ${viewModel.todos.length}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
