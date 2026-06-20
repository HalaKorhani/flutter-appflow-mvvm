import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../repositories/todo_repository.dart';

// ViewModel responsible for todo list state and API loading logic.
class TodoViewModel extends ChangeNotifier {
  final TodoRepository _repository;

  TodoViewModel(this._repository);

  List<Todo> todos = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadTodos() async {
    // Show loading indicator in the UI.
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Ask repository to fetch todos from the API.
      todos = await _repository.fetchTodos();
    } catch (e) {
      // Save error message so the UI can display it.
      errorMessage = e.toString();
    }

    // Hide loading indicator after request finishes.
    isLoading = false;
    notifyListeners();
  }
}
