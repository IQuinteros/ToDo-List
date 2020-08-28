import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_bottom.dart';
import 'package:task_management_app/task/ui/widgets/task_date_input.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';

class ViewTaskScreen extends StatefulWidget {
  Task task;

  ViewTaskScreen({
    @required this.task
  });

  @override
  _ViewTaskScreenState createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    final upBanner = Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      decoration: BoxDecoration(
        color: widget.task.getColor(),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0,1)
          )
        ]
      ),
    );

    final title = Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20
      ),
      child: Text(
        widget.task.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: "Lato",
          color: Colors.blue
        ),
      ),
    );

    final titleRow = Row(
      children: [
        title
      ],
    );

    final description = Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 100
      ),
      child: Text(
        widget.task.detail,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(10, 36, 99, 1),
          fontFamily: "Lato",
          fontSize: 15,
        ),
      ),
    );

    final buttonEdit = Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20
      ),
      child: RaisedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen(toAdd: widget.task, onSaveTask: (Task newTask){
            setState(() {
              widget.task = newTask;
            });
          },)));
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Container(
          height: 40,
          child: Center(
            child: Text(
              "Editar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "Lato"
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
        ),
      )
    );

    final deleteButton = Container(
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 40
        ),
        child: RaisedButton(
          onPressed: () async {
            _onDeletePressed(userBloc, widget.task);
          },
          color: Color.fromRGBO(168, 0, 0, 1),
          textColor: Colors.white,
          child: Container(
            height: 40,
            child: Center(
              child: Text(
                "Eliminar Tarea",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Lato"
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        )
    );

    final screenStructure = Column(
      children: [
        upBanner,
        title,
        Expanded(
          child: ListView(
            children: [
              description,
              TaskDateInput(enabled: false, initialDate: widget.task.finishDate,),
              buttonEdit,
              deleteButton
            ],
          ),
        ),
        TaskBottom(state: widget.task.status, task: widget.task,)
      ],
    );


    final design = Stack(
      children: [
        BackgroundGradient(
          maxOpacity: 0.2,
        ),
        BackgroundTexture(
          opacity: 0.2,
        ),
        screenStructure
      ],
    );

    final scaffold = Scaffold(
      //appBar: AppBar(
        //title: Text("Tarea Seleccionada"),
        //shadowColor: Colors.blue,
      //),
      body: design,
    );

    return scaffold;
  }

  Future<bool> _onDeletePressed(UserBloc userBloc, Task taskRef) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Eliminar Tarea'),
        content: new Text('Una vez eliminado, no se puede recuperar'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("VOLVER"),
            ),
          ),
          SizedBox(height: 16),
          new RaisedButton(
            onPressed: () async {
              await userBloc.removeTask(taskRef);
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);

              Flushbar(
                message: "Tarea eliminada",
                leftBarIndicatorColor: taskRef.getColor(),
                padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 20
                ),

                boxShadows: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                duration: Duration(seconds: 3),
                forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                dismissDirection: FlushbarDismissDirection.HORIZONTAL,
              ).show(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("ELIMINAR"),
            ),
            color: Color.fromRGBO(168, 0, 0, 1),
          ),
        ],
      ),
    ) ??
        false;
  }
}
