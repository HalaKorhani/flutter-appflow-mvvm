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
}
