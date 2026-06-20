// Model class for one todo item returned by JSONPlaceholder.
// This model represents the structure of each task from the API.
class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  // Converts JSON map from the API into a Todo object.
  // This is used when we fetch data from:
  // https://jsonplaceholder.typicode.com/todos
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
