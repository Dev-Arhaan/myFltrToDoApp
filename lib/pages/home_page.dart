import 'package:flutter/material.dart';
import 'package:myapp/utils/dialogBox.dart';
import 'package:myapp/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  // List of tasks
  List TodoList = [
    ["Make an app", false],
    ["Do exercise", false]
  ];

  // CheckBox was tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      TodoList[index][1] = !TodoList[index][1];
    });
  }

  // remove dialog box
  void popDlgBox() => Navigator.of(context).pop();

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      TodoList.removeAt(index);
    });
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      TodoList.add([_controller.text, false]);
    });
    _controller.clear();
    popDlgBox();
  }

  // create a new Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return dialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: popDlgBox,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: TodoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: TodoList[index][0],
            taskCompleted: TodoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
