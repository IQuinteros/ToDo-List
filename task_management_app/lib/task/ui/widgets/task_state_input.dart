import 'package:flutter/material.dart';

class TaskStateInput extends StatefulWidget {
  @override
  _TaskStateInputState createState() => _TaskStateInputState();
}

class _TaskStateInputState extends State<TaskStateInput> {
  String dropdownValue = 'Para Hacer';

  @override
  Widget build(BuildContext context) {

    final formField = DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Color.fromRGBO(10, 36, 99, 1)),

      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Para Hacer', 'En Desarrollo', 'Terminado']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

      decoration: InputDecoration(
        hintText: "Título de la Tarea",
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
