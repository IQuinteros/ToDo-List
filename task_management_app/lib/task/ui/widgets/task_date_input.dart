import 'package:flutter/material.dart';

class TaskDateInput extends StatefulWidget {

  final bool enabled;
  final DateTime initialDate;

  void Function(DateTime) onNewDate;

  DateTime selectedDate;

  TaskDateInput({this.enabled = true, this.initialDate, this.onNewDate}){
    selectedDate = initialDate;
  }

  @override
  _TaskDateInputState createState() {
    return _TaskDateInputState();
  }
}

class _TaskDateInputState extends State<TaskDateInput> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        helpText: "Escoger una fecha de vencimiento para la tarea",
        confirmText: "CONFIRMAR",
        cancelText: "CANCELAR",

        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.selectedDate)
      setState(() {
        widget.selectedDate = picked;
        widget.onNewDate(picked);
      });
  }

  @override
  Widget build(BuildContext context) {

    try {
      widget.onNewDate(widget.selectedDate);
    }catch(e){}

    VoidCallback onPressed;

    if(widget.enabled){
      onPressed = (){
        _selectDate(context);
        widget.onNewDate(widget.selectedDate);
      };
    }

    final textForm = OutlineButton(
      onPressed: onPressed,
      borderSide: new BorderSide(),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.selectedDate.day}/${widget.selectedDate.month.toString()}/${widget.selectedDate.year}",
              style: TextStyle(
                color: Color.fromRGBO(10, 36, 99, 1),
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ),
    );

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10
            ),
            child: Text(
              "Fecha de Vencimiento",
              style: TextStyle(
                fontFamily: "Lato"
              ),
            ),
          ),
          textForm
        ],
      ),
      margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10
      ),
    );
  }
}
