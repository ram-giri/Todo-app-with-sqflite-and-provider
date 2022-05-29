import 'package:flutter/material.dart';
import 'database.dart';
import 'todo.dart';

class TodoModel extends ChangeNotifier {
  // Declare Todos in Private
  List<Todo> _todos = [];

  void loadTodos() async {
    _todos = await DatabaseHelper.instance.listAllTodo();
    notifyListeners();
  }

  // Getter
  List<Todo> get items => _todos;

  // Add Todo
  void addTodo(Todo todo) async {
    await DatabaseHelper.instance.addTodo(todo);
    loadTodos();
  }

  /// To Delete Todo By ID
  void deleteTodo(int i) async {
    await DatabaseHelper.instance.deleteTodo(i);
    loadTodos();
  }

  /// To Delete Todo By ID
  void deleteAll() async {
    await DatabaseHelper.instance.deleteAll();
    loadTodos();
  }

  /// Update Todo
  void updateTodo(Todo todo) async {
    await DatabaseHelper.instance.updateTodo(todo);
    loadTodos();
  }
}
