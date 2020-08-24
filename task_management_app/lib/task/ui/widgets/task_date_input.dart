import 'package:flutter/material.dart';

class TaskDateInput extends StatefulWidget {
  @override
  _TaskDateInputState createState() => _TaskDateInputState();
}

class _TaskDateInputState extends State<TaskDateInput> {

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        helpText: "Escoger una fecha de vencimiento para la tarea",
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
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

    final textForm = OutlineButton(
      onPressed: (){
        _selectDate(context);
      },
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
              "24/08/2020",
              style: TextStyle(
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
