import 'package:flutter/material.dart';
import 'package:todo_app_02_02_21/Widget/addTodo.dart';
import 'package:todo_app_02_02_21/Widget/viewTodo.dart';
import 'package:todo_app_02_02_21/module/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //Create the TodoList
  final List<TODO> _todoItems = [
    TODO(id: DateTime.now().toString(), name: "Test"),
    // TODO(id: DateTime.now().toString(), name: "123"),
    // TODO(id: DateTime.now().toString(), name: "321"),
  ];

  //Delete The item
  void _deleteTODOItem(String id) {
    debugPrint("DeleteTODOItems $id");
    setState(() {
      _todoItems.removeWhere((tx) => tx.id == id);
    });
  }

  //Edit The item
  void _editTODOItem(
    ctx,
    String id,
    String name,
    String date,
    String time,
  ) {
    debugPrint("editTODOItem $id $name $date $time");
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: AddTodo(
              id: id,
              name: name,
              date: date,
              time: time,
              updateTodo: _updateTODOItem,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  //Update The item
  void _updateTODOItem(String id, String name, String date, String time) {
    debugPrint("Update TODOItem  Details $id $name  $date $time");
    setState(() {
      _todoItems.removeWhere((tx) => tx.id == id);
    });

    final upTodo = TODO(id: id, name: name, date: date, time: time);
    setState(() {
      _todoItems.add(upTodo);
    });
  }

  //Add The item
  void _addTODOItem(String name, String date, String time) {
    debugPrint("_addTODOItem Inside $name");
    debugPrint("_addTODOItem Inside $date");
    debugPrint("_addTODOItem Inside $time");

    final newTodo =
        TODO(id: DateTime.now().toString(), name: name, date: date, time: time);

    setState(() {
      _todoItems.add(newTodo);
    });
    for (int i = 0; i < _todoItems.length; i++) {
      debugPrint(_todoItems[i].id);
      debugPrint(_todoItems[i].name);
      debugPrint(_todoItems[i].date);
      debugPrint(_todoItems[i].time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addTodoList(context),
          ),
        ],
      ),
      body: ViewTodo(_todoItems, _deleteTODOItem, _editTODOItem),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodoList(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _addTodoList(BuildContext ctx) {
    debugPrint("addTodoList Called....!");
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: AddTodo(addTodo: _addTODOItem),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
