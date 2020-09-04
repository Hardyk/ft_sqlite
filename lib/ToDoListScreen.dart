import 'package:flutter/material.dart';
import 'package:ft_sqlite/CreateToDoScreen.dart';
import 'package:ft_sqlite/Database.dart';
import 'package:ft_sqlite/Todo.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  ToDoListScreenState createState() => ToDoListScreenState();
}

class ToDoListScreenState extends State<ToDoListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: DatabaseHelper.instance.retrieveTodos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final Todo item = snapshot.data[index];
                return ListTile(
                  title: Text(item.title),
                  leading: Text((index + 1).toString()),
                  subtitle: Text(item.content),
                  onTap: () => navigateToDetail(context, item),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        deleteTodo(item);
                        setState(() {});
                      }),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "No ToDos available!",
                style: TextStyle(fontSize: 15),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text("Oops!");
        } else {
          return Center(
            child: Text(
              "No ToDos available!",
              style: TextStyle(fontSize: 15),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

deleteTodo(Todo todo) {
  DatabaseHelper.instance.deleteTodo(todo.id);
}

navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CreateToDoScreen(todo: todo)),
  );
}
