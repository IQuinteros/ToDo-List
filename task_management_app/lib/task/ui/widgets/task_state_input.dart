import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';

class TaskStateInput extends StatefulWidget {
  final Task task;

  void Function(TaskState) onNewState;

  TaskStateInput({this.task, this.onNewState});

  TaskState selectedValue = TaskState.ToDo;

  TaskState initValue(){
    if(task != null){
      return task.status;
    }
    else{
      return TaskState.ToDo;
    }
  }

  @override
  _TaskStateInputState createState(){
    selectedValue = initValue();
    return _TaskStateInputState();
  }
}

class _TaskStateInputState extends State<TaskStateInput> {

  @override
  Widget build(BuildContext context) {

    widget.onNewState(widget.selectedValue);

    final formField = DropdownButtonFormField<String>(
      value: Task.stateToString(widget.selectedValue),
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Color.fromRGBO(10, 36, 99, 1)),

      onChanged: (String newValue) {
        setState(() {
          widget.selectedValue = Task.stringToState(newValue);
          widget.onNewState(widget.selectedValue);
        });
      },
      items: <String>[Task.TODO_TEXT, Task.DOING_TEXT, Task.DONE_TEXT]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            margin: EdgeInsets.only(
              left: 10
            ),
            child: Text(
              value,
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 15
              ),
            ),
          )
        );
      }).toList(),

      decoration: InputDecoration(
        hintText: "Título de la Tarea",
        helperText: "Estado de la tarea",
        focusColor: Colors.blue,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
    );

    return Container(
      child: formField,
      margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10
      ),
    );
  }
}
