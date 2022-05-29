import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/clear.dart';
import '../widgets/add_update.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allTodos = Provider.of<TodoModel>(context);
    allTodos.loadTodos();
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: const Text("My Todos"),
        actions: [
          IconButton(
            onPressed: () {
              clearDialog(context);
            },
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: allTodos.items.isEmpty
            ? const Center(
                child: Text(
                  "No Todo Found",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: allTodos.items.length,
                itemBuilder: (ctx, i) {
                  String isChecked = allTodos.items[i].isChecked;
                  bool isDone = isChecked == 'false' ? false : true;
                  return Card(
                    child: ListTile(
                      title: Text(allTodos.items[i].title),
                      subtitle: Text(allTodos.items[i].discription),
                      leading: Checkbox(
                          value: isDone,
                          onChanged: (value) {
                            if (value == false) {
                              allTodos.updateTodo(
                                Todo(
                                    id: allTodos.items[i].id,
                                    title: allTodos.items[i].title,
                                    discription: allTodos.items[i].discription,
                                    isChecked: isChecked == 'false'
                                        ? 'true'
                                        : 'false'),
                              );
                            } else {
                              allTodos.updateTodo(
                                Todo(
                                    id: allTodos.items[i].id,
                                    title: allTodos.items[i].title,
                                    discription: allTodos.items[i].discription,
                                    isChecked: isChecked == 'false'
                                        ? 'true'
                                        : 'false'),
                              );
                            }
                          }),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.brown[900],
                            ),
                            onPressed: () {
                              addOrUpdateDialog(context, false,
                                  todo: allTodos.items[i], index: i);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 20.0,
                              color: Colors.brown[900],
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text("Do you want to  delete?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              allTodos.deleteTodo(
                                                  allTodos.items[i].id!);
                                              Navigator.pop(context);
                                            },
                                            child:
                                                const Text("Confirm Delete")),
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"))
                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addOrUpdateDialog(context, true);
        },
      ),
    );
  }
}
