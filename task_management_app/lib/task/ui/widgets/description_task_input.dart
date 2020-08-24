import 'package:flutter/material.dart';

class DescriptionTaskInput extends StatefulWidget {
  @override
  _DescriptionTaskInputState createState() => _DescriptionTaskInputState();
}

class _DescriptionTaskInputState extends State<DescriptionTaskInput> {
  @override
  Widget build(BuildContext context) {
    final textForm = TextFormField(
      validator: (value){
        if(value.isEmpty){
          return 'Ingresa una descripción para la tarea';
        }
      },
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      minLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(
            Icons.assignment_late
        ),
        hintText: "Añade una descripción",
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
