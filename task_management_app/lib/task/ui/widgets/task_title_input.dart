import 'package:flutter/material.dart';

class TaskTitleInput extends StatefulWidget {
  final TextEditingController controller;

  TaskTitleInput({this.controller});

  @override
  _TaskTitleInputState createState() => _TaskTitleInputState();
}

class _TaskTitleInputState extends State<TaskTitleInput> {
  @override
  Widget build(BuildContext context) {
    final textForm = TextFormField(
      validator: (value){
        if(value.isEmpty){
          return 'Ingresa el título de la nueva tarea';
        }
      },
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.assignment_late
        ),
        hintText: "Título de la Tarea",
        focusColor: Colors.blue,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      style: TextStyle(
        fontFamily: "Lato"
      ),
    );

    return Container(
      child: textForm,
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10
      ),
    );
  }
}
