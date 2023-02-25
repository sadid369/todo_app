import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/Widgets/button.dart';
import 'package:todo_app/Widgets/custom_text_fields.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/constant/gobal_variable.dart';
import 'package:todo_app/model/todo.dart';

class TodoHome extends ConsumerStatefulWidget {
  const TodoHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHomeState();
}

class _TodoHomeState extends ConsumerState<TodoHome> {
  final TextEditingController textEditingController = TextEditingController();
  TextEditingController? updateTextController;

  final GlobalKey _fromKey = GlobalKey<FormState>();
  String text = 'Nothing';
  List<Todo> todoList = [];

  addTextToTodo() async {
    try {
      Todo todo = Todo(todo: textEditingController.text, id: "");
      http.Response res = await http.post(Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: todo.toJson());
      setState(() {
        todoList.add(Todo.fromMap(jsonDecode(res.body)));
      });
      textEditingController.clear();
    } catch (e) {
      print("$e from here");
    }
  }

  getData() async {
    try {
      http.Response res = await http.get(Uri.parse('$uri/'));
      var decodedData = jsonDecode(res.body) as List;
      decodedData.forEach((element) {
        todoList.add(Todo.fromMap(element));

        print(element['todo']);
      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> openDialog(
      {required String? prefixText,
      required TextEditingController updateText}) {
    updateTextController = updateText;
    return showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Update Tod"),
              content: TextFormField(
                controller: updateTextController,
                autofocus: true,
                decoration: InputDecoration(),
              ),
              actions: [
                TextButton(onPressed: update, child: const Text("Update"))
              ],
            ));
  }

  void update() {
    Navigator.of(context).pop(updateTextController!.text);
  }

  void updateTodo({required String id, required String updatedText}) async {
    try {
      // Todo todo = Todo(todo: "", id: "");
      http.Response res = await http.patch(
        Uri.parse("$uri/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: Todo(todo: updatedText, id: id).toJson(),
      );
      print(res.body);
      var todoIndex = todoList
          .indexWhere((element) => element.id == jsonDecode(res.body)["_id"]);
      setState(() {
        todoList[todoIndex] = Todo.fromMap(jsonDecode(res.body));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    updateTextController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: Form(
                  key: _fromKey,
                  child: TextFormField(
                    controller: textEditingController,
                    // decoration: InputDecoration(
                    //   border: const OutlineInputBorder(),
                    // ),
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter Something";
                      } else {
                        return null;
                      }
                    },
                  ),
                )),
                CustomButton(
                    icon: Icons.add,
                    onTap: () async {
                      addTextToTodo();
                      setState(() {});
                    })
              ],
            ),
            Container(
              height: 300,
              width: 200,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        todoList[index].todo,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                            IconButton(
                                onPressed: () async {
                                  final update = await openDialog(
                                      updateText: TextEditingController(
                                          text: todoList[index].todo),
                                      prefixText: todoList[index].todo);
                                  if (update == null || update.isEmpty) {
                                    return print('Empty');
                                  }
                                  updateTodo(
                                      id: todoList[index].id,
                                      updatedText: update);
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
