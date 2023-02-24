import 'dart:convert';

class Todo {
  final String todo;
  final String id;
  Todo({
    required this.todo,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'todo': todo,
      'id': id,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todo: map['todo'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
