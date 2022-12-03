import 'dart:convert';

class Todo {
  String id;
  String name;
  String created;
  String updated;
  bool is_completed;
  String user_id;
  Todo({
    required this.id,
    required this.name,
    required this.created,
    required this.updated,
    required this.is_completed,
    required this.user_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created': created,
      'updated': updated,
      'is_completed': is_completed,
      'user_id': user_id,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
      is_completed: map['is_completed'] ?? false,
      user_id: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
