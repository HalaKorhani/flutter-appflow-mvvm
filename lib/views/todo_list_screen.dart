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

    if (viewModel.errorMessage != null && viewModel.todos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 12),
              Text(viewModel.errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: viewModel.loadTodos,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshTodos,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.todos.length,
        itemBuilder: (context, index) {
          final todo = viewModel.todos[index];
          final backgroundColor = todo.completed
              ? Colors.green.shade100
              : Colors.orange.shade100;

          return Card(
            color: backgroundColor,
            child: ListTile(
              leading: Icon(
                todo.completed ? Icons.check_circle : Icons.pending,
                color: todo.completed ? Colors.green : Colors.orange,
              ),
              title: Text(todo.title),
              subtitle: Text(todo.completed ? 'Completed' : 'Incomplete'),
            ),
          );
        },
      ),
    );
  }
}
