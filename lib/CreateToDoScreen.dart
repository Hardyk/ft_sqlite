import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ft_sqlite/Database.dart';
import 'package:ft_sqlite/Todo.dart';

class CreateToDoScreen extends StatefulWidget {
  static const routeName = '/detailTodoScreen';
  final Todo todo;

  const CreateToDoScreen({Key key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateTodoState(todo);
}

class CreateTodoState extends State<CreateToDoScreen> {
  Todo todo;
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

  CreateTodoState(this.todo);

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      descriptionTextController.text = todo.content;
      titleTextController.text = todo.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
              maxLines: 1,
              controller: titleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              maxLines: 10,
              controller: descriptionTextController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            _saveTodo(titleTextController.text, descriptionTextController.text);
            setState(() {});
          }),
    );
  }

  _saveTodo(String title, String content) async {
    if (title.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter ToDo title/description",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (todo == null) {
        DatabaseHelper.instance.insertTodo(Todo(
            title: titleTextController.text,
            content: descriptionTextController.text));
        Navigator.pop(context, "Your todo has been saved.");
      } else {
        await DatabaseHelper.instance.updateTodo(Todo(
            id: todo.id,
            title: title,
            content: content));
        Navigator.pop(context);
      }

      Fluttertoast.showToast(
          msg: "Your todo has been saved.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
