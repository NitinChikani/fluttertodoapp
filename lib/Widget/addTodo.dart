import 'package:flutter/material.dart';
import 'package:todo_app_02_02_21/module/todo.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AddTodo extends StatefulWidget {
  final Function addTodo;
  final Function updateTodo;
  final String name;
  final String id;
  final String date;
  final String time;

  AddTodo(
      {this.addTodo,
      this.id,
      this.name,
      this.date,
      this.time,
      this.updateTodo});
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        _timeController.text = "${_time.format(context)}";
      });
    }
  }

  bool _validate = false;
  bool _datevalidate = false;
  bool _timevalidate = false;
  DateTime _selectDate;

  @override
  void initState() {
    if (widget.id != null) {
      _nameController.text = widget.name;
      _idController.text = widget.id;
      _dobController.text = widget.date;
      _timeController.text = widget.time;
    }
    super.initState();
    debugPrint("Add Profile InitState Called");
  }

  //DatePicker Dialog
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;

        _dobController.text = DateFormat.yMMMd().format(pickedDate);
      });
    });
  }

  //Validation Form
  void _fromValidation() {
    if (widget.id == null) {
      debugPrint("Add Button Clicked");
      final name = _nameController.text;
      final dates = _dobController.text;
      final times = _timeController.text;
      if (name.isEmpty && dates.isEmpty && times.isEmpty) {
        setState(() {
          _validate = true;
          _datevalidate = true;
          _timevalidate = true;
        });
        return;
      }
      Navigator.pop(context);
      _nameController.clear();
      widget.addTodo(
        name,
        dates,
        times,
      );
    } else {
      debugPrint("Update Button Clicked");
      final name = _nameController.text;
      final id = widget.id;
      final dates = _dobController.text;
      final times = _timeController.text;
      if (name.isEmpty || dates.isEmpty || times.isEmpty) {
        setState(() {
          _validate = true;
          _datevalidate = true;
          _timevalidate = true;
        });
        return;
      } else {
        widget.updateTodo(id, name, dates, times);
        Navigator.pop(context);
        _nameController.clear();
        _idController.clear();
        _dobController.clear();
        _timeController.clear();
      }
    }
  }

  @override
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _timeController = TextEditingController();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.5,
        child: Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  widget.id == null
                      ? "Add Todo".toUpperCase()
                      : "Update Todo".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.blueAccent),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'NAME',
                    errorText: _validate ? 'Name Required.!' : null,
                  ),
                  controller: _nameController,
                ),
                TextField(
                  onTap: _presentDatePicker,
                  decoration: InputDecoration(
                      hintText: "SELECT DATE",
                      errorText: _datevalidate ? 'Date Required.!' : null),
                  controller: _dobController,
                ),
                TextField(
                  onTap: _selectTime,
                  decoration: InputDecoration(
                      hintText: "SELECT TIME",
                      errorText: _timevalidate ? 'Time Required.!' : null),
                  controller: _timeController,
                ),
                RaisedButton(
                  onPressed: _fromValidation,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  elevation: 1.5,
                  child: Text(
                    widget.id == null
                        ? "Add ".toUpperCase()
                        : "Update ".toUpperCase(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
