import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../module/todo.dart';

class ViewTodo extends StatelessWidget {
  final List<TODO> todoItems;
  final Function deleteItem;
  final Function editItem;
  ViewTodo(this.todoItems, this.deleteItem, this.editItem);
  @override
  Widget build(Object context) {
    return Container(
      child: todoItems.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Todo List Empty. ',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/box.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text('${todoItems[index].name}'),
                      subtitle: Text('${todoItems[index].date}  ' +
                          '${todoItems[index].time}'),
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blueAccent,
                      icon: Icons.edit,
                      onTap: () {
                        editItem(
                            context,
                            todoItems[index].id,
                            todoItems[index].name,
                            todoItems[index].date,
                            todoItems[index].time);
                      },
                      // onTap: () => _showSnackBar('More'),
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Warning"),
                                content: Text(
                                    "Are you sure want to delete Todo ${todoItems[index].name}?"),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      deleteItem(todoItems[index].id);
                                      Navigator.pop(context);
                                      debugPrint("Delete Yes Button Clicked..");
                                    },
                                    child: Text("YES"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      // apiService.deleteProfile(profile.id);
                                      Navigator.pop(context);
                                      // setState(() {
                                      //   apiService.getProfiles();
                                      // });
                                      debugPrint("Delete No Button Clicked..");
                                    },
                                    child: Text("NO"),
                                  ),
                                ],
                              );
                            });
                      },
                      // onTap: () => _showSnackBar('Delete'),
                    ),
                  ],
                );
              },
              itemCount: todoItems.length,
            ),
    );
  }
}
