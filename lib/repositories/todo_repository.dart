import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo.dart';

// Repository responsible for fetching todo data from the API.
// This keeps API logic outside the UI and ViewModel.
class TodoRepository {
  // API link required by the assignment.
  static const String _url = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Todo>> fetchTodos() async {
    // Send GET request to the API.
    final response = await http.get(Uri.parse(_url));

    // If the API does not return success, throw an error.
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load todos. Status code: ${response.statusCode}',
      );
    }

    // Convert the JSON response body into a Dart List.
    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

    // Convert each JSON item into a Todo object.
    return jsonList
        .map((item) => Todo.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
