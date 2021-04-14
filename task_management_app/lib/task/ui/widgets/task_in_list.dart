import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/screens/view_task_screen.dart';

class TaskInList extends StatefulWidget {
  Task task;

  TaskInList({
    @required this.task
  });

  @override
  _TaskInListState createState() => _TaskInListState();
}

class _TaskInListState extends State<TaskInList> {
  @override
  Widget build(BuildContext context) {

    final colorBox = Container(
      height: 70,
      width: 10,
      decoration: BoxDecoration(
        color: widget.task.getColor(),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );

    final textZone = Container(
      margin: EdgeInsets.only(
        left: 20
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.task.name,
              style: TextStyle(
                color: Color.fromRGBO(10, 36, 99, 1),
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5
              ),
              child: Text(
                "${widget.task.finishDate.day}/${widget.task.finishDate.month}/${widget.task.finishDate.year}",
                style: TextStyle(
                    color: Color.fromRGBO(10, 36, 99, 1),
                    fontFamily: "Lato",
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),
              ),
            ),
          ],
      ),
    );

    final allContent = Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        children: [
          colorBox,
          textZone
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 2
          )
        ]
      ),
    );

    final toReturn = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.only(
          left: 5,
          right: 5
      ),
      child: InkWell(
        child: allContent,
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTaskScreen(task: widget.task,)));
        },
      ),
    );

    return Draggable(
      child: toReturn,
      childWhenDragging: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
      ),
      feedback: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              colorBox,
              Container(
                child: Text(
                  widget.task.name,
                  style: TextStyle(
                      color: Color.fromRGBO(10, 36, 99, 1),
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
                margin: EdgeInsets.only(
                  left: 10
                ),
              )
            ],
          ),
        ),
        width: 250,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
              offset: Offset(0,1)
            )
          ]
        ),
      ),
    );
  }
}
