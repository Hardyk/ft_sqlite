import 'dart:convert';

Todo toDoFromJson(String str) {
  final jsonData = json.decode(str);
  return Todo.fromMap(jsonData);
}

String toDoToJson(Todo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Todo {
  final int id;
  final String content;
  final String title;

  static const String TABLENAME = "todos";

  Todo({this.id, this.content, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'title': title,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> json) => new Todo(
        id: json["id"],
        content: json["content"],
        title: json["title"],
      );
}
