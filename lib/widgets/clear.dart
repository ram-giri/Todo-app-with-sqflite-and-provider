import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import '../models/provider.dart';

clearDialog(BuildContext context, {Todo? todo, int? index}) {
  final allTodos = Provider.of<TodoModel>(context, listen: false);

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to  Delete all Todos?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  allTodos.deleteAll();
                  Navigator.pop(context);
                },
                child: const Text("Confirm Delete")),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"))
          ],
        );
      });
}
