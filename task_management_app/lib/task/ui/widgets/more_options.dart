import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/task_color_picker.dart';
import 'package:task_management_app/task/ui/widgets/task_state_input.dart';

class MoreOptions extends StatefulWidget {

  bool isOpen = false;
  final VoidCallback onOpenTap;

  void Function(TaskState) onNewStatus;
  void Function(String) onNewColor;

  final Task task;

  MoreOptions({this.task, this.isOpen, @required this.onOpenTap, this.onNewColor, this.onNewStatus});

  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {

  @override
  Widget build(BuildContext context) {

    final line = Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 5,
        right: 5
      ),
      width: MediaQuery.of(context).size.width,
      height: 2,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
    );

    final button = InkWell(
      onTap: (){
        setState(() {
          widget.isOpen = !widget.isOpen;
          widget.onOpenTap();
        });
      },
      child: Container(
        child: Icon(
          widget.isOpen? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 35,
        ),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
      ),
    );

    Widget bottomWidget = Container();

    if(!widget.isOpen){
      bottomWidget = Container(
        margin: EdgeInsets.only(
            top: 10
        ),
        child: Text(
          "Más Opciones",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: "Lato",
              color: Color.fromRGBO(10, 36, 99, 1)
          ),
        ),
      );
    }
    else{
      bottomWidget = Container(
        margin: EdgeInsets.only(
          top: 10
        ),
        child: Column(
          children: [
            TaskStateInput(task: widget.task, onNewState: widget.onNewStatus,),
            TaskColorPicker(task: widget.task, onNewColor: widget.onNewColor,)
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(
        top: 20
      ),
      child: Column(
        children: [
          Stack(
            children: [
              line,
              Center(
                child: button,
              )
            ],
          ),
          bottomWidget
        ],
      )
    );
  }
}
