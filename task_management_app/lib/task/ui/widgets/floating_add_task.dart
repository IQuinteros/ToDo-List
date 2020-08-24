import 'package:flutter/material.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';

class FloatingAddTask extends StatefulWidget {

  final bottomMargin;

  FloatingAddTask({
   this.bottomMargin = 0.0
  });

  @override
  _FloatingAddTaskState createState() => _FloatingAddTaskState();
}

class _FloatingAddTaskState extends State<FloatingAddTask> {
  @override
  Widget build(BuildContext context) {
    final toDisplay = FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
      },
      tooltip: 'Añadir Tarea',
      child: Icon(Icons.add)
    );

    return Container(
      child: toDisplay,
      margin: EdgeInsets.only(
        bottom: widget.bottomMargin
      ),
    );
  }
}
