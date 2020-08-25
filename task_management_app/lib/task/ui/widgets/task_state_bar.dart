import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/task_in_list.dart';

class TaskStateBarInList{

  final TaskState state;

  bool isExpanded = false;

  String title;

  TaskStateBarInList({
    @required this.state,
    this.isExpanded = false
  });

  ExpansionPanel build(){

    switch(state){
      case TaskState.ToDo:
        title = "Por Hacer";
        break;
      case TaskState.Doing:
        title = "En Desarrollo";
        break;
      case TaskState.Done:
        title = "Terminados";
        break;
    }

    final bar = Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(
          left: 20
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(10, 36, 99, 1),
              fontWeight: FontWeight.bold,
              fontFamily: "Lato"
          ),
        )
    );

    List<Widget> tasks = List();

    tasks.add(TaskInList(task: Task.generateRandomTask(),));
    tasks.add(TaskInList(task: Task.generateRandomTask()));
    tasks.add(TaskInList(task: Task.generateRandomTask()));

    final listTasks = Container(
      margin: EdgeInsets.only(
        top: 5,
        bottom: 10
      ),
      child: Column(
          children: tasks
      ),
    );

    return ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded){
          return bar;
        },
        body:  listTasks,
        canTapOnHeader: true,
        isExpanded: isExpanded
    );
  }
}

class TaskStateBar extends StatefulWidget {

  final TaskState state;
  bool isOpen;

  TaskStateBar({
    @required this.state,
    this.isOpen = false
  });

  @override
  _TaskStateBarState createState() => _TaskStateBarState();
}

class _TaskStateBarState extends State<TaskStateBar> {

  var title;

  @override
  Widget build(BuildContext context) {

    IconData icon = widget.isOpen? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;

    switch(widget.state){
      case TaskState.ToDo:
        title = "Por Hacer";
        break;
      case TaskState.Doing:
        title = "En Desarrollo";
        break;
      case TaskState.Done:
        title = "Terminados";
        break;
    }

    final bar = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10
      ),
      child:
           Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(10, 36, 99, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato"
                ),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    widget.isOpen = !widget.isOpen;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Color.fromRGBO(10, 36, 99, 1),
                  ),
                ),
              ),
            ],
          )

    );

    var toDisplay;

    if(widget.isOpen){

      // RANDOM NUM OF TASK IN LIST
      List<Widget> tasks = List();

      int randNumber = Random().nextInt(10);

      tasks.add(TaskInList());
      tasks.add(TaskInList());
      tasks.add(TaskInList());
      //for(int i = 0; i < randNumber; i++){
       // tasks.add(TaskInList());
      //}

      final listTasks = Container(
        margin: EdgeInsets.only(
            top: 5
        ),
        child: Column(
          children: tasks
        ),
      );

      toDisplay = Column(
        children: [
          bar,
          listTasks
        ],
      );
    }
    else{
      toDisplay = bar;
    }

    List<Widget> tasks = List();

    int randNumber = Random().nextInt(4);

    tasks.add(TaskInList());
    tasks.add(TaskInList());
    tasks.add(TaskInList());

    final listTasks = Container(
      margin: EdgeInsets.only(
          top: 5
      ),
      child: Column(
          children: tasks
      ),
    );

    toDisplay = ExpansionPanel(
      headerBuilder: (context, isExpanded){
        return bar;
      },
      body: listTasks
    );

    return toDisplay;
  }
}
