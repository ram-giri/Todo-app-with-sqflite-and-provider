import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import '../models/provider.dart';

addOrUpdateDialog(BuildContext context, bool isAdded,
    {Todo? todo, int? index}) {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  TextEditingController cID = TextEditingController();

  if (!isAdded) {
    cTitle.text = todo!.title;
    cDesc.text = todo.discription;
    cID.text = todo.id.toString();
  }

  final allTodos = Provider.of<TodoModel>(context, listen: false);
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: isAdded ? const Text("Add Todo") : const Text("Update Todo"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: cTitle,
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: cDesc,
          decoration: const InputDecoration(labelText: "Description"),
          maxLength: null,
        ),
      ],
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            if (isAdded) {
              allTodos.addTodo(Todo(
                id: Random().nextInt(1000),
                title: cTitle.text,
                discription: cDesc.text,
                isChecked: 'false',
              ));
            } else {
              // Update Code
              allTodos.updateTodo(Todo(
                id: int.parse(cID.text),
                title: cTitle.text,
                discription: cDesc.text,
                isChecked: 'false',
              ));
            }
            Navigator.pop(context);
          },
          child: const Text("Save")),
      OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"))
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
