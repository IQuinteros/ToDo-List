import 'package:flutter/material.dart';

class TaskDateInput extends StatefulWidget {

  final bool enabled;
  final DateTime initialDate;

  TaskDateInput({this.enabled = true, this.initialDate});

  @override
  _TaskDateInputState createState() => _TaskDateInputState();
}

class _TaskDateInputState extends State<TaskDateInput> {

  DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        helpText: "Escoger una fecha de vencimiento para la tarea",
        confirmText: "CONFIRMAR",
        cancelText: "CANCELAR",
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.initialDate != null){
      selectedDate = widget.initialDate;
    }
    else{
      selectedDate = DateTime.now();
    }

    final example = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(height: 20.0,),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select date'),
          ),
        ],
      ),
    );

    VoidCallback onPressed;

    if(widget.enabled){
      onPressed = (){
        _selectDate(context);
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
              "${selectedDate.day}/${selectedDate.month.toString()}/${selectedDate.year}",
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

    final datePicker = CalendarDatePicker(
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      onDateChanged: (DateTime date) {},
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
