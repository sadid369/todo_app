import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/Widgets/button.dart';
import 'package:todo_app/Widgets/text_fields.dart';

class TodoHome extends ConsumerStatefulWidget {
  const TodoHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHomeState();
}

class _TodoHomeState extends ConsumerState<TodoHome> {
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey _fromKey = GlobalKey<FormState>();
  String text = 'Nothing';
  List<String> todoList = [];
  addTextToTodo() {
    setState(() {
      todoList.add(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Something";
                      } else {
                        return null;
                      }
                    },
                  ),
                )),
                CustomButton(
                    icon: Icons.add,
                    onTap: () {
                      addTextToTodo();
                    })
              ],
            ),
            Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        todoList[index],
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.delete),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.edit),
                            ),
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
