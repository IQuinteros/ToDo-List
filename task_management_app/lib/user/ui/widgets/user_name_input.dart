import 'package:flutter/material.dart';

class UserNameInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String warningText;

  UserNameInput({this.controller, this.hintText, this.warningText});

  @override
  _UserNameInputState createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  @override
  Widget build(BuildContext context) {
    final textForm = TextFormField(
      validator: (value){
        if(value.isEmpty){
          return widget.warningText;
        }
      },
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
            Icons.account_circle
        ),
        hintText: widget.hintText,
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
