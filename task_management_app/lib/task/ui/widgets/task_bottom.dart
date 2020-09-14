import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/user/model/user.dart';

class TaskBottom extends StatefulWidget {
  TaskState state;

  Task task;

  TaskBottom({
    this.state = TaskState.Doing,
    @required this.task
  });

  @override
  _TaskBottomState createState() => _TaskBottomState();
}

class _TaskBottomState extends State<TaskBottom> {

  UserBloc userBloc;
  ZUser user;

  void _setTaskState(TaskState newState){
    widget.task.status = newState;
    userBloc.setDataTask(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    user = ZUser.getCurrentUser;

    final backButton = InkWell(
      onTap:(){
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );

    final state = InkWell(
        onTap: (){
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bcontext){
                return Container(
                  child: new Wrap(
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.assignment_late),
                        title: new Text('Por Hacer'),
                        onTap: (){
                          setState(() {
                            widget.state = TaskState.ToDo;
                          });
                          _setTaskState(TaskState.ToDo);
                          Navigator.of(context).pop();
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.assignment),
                        title: new Text('En Desarrollo'),
                        onTap: (){
                          setState(() {
                            widget.state = TaskState.Doing;
                          });
                          _setTaskState(TaskState.Doing);
                          Navigator.of(context).pop();
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.assignment_turned_in),
                        title: new Text('Terminado'),
                        onTap: (){
                          setState(() {
                            widget.state = TaskState.Done;
                          });
                          _setTaskState(TaskState.Done);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
          );
        },

        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
              left: 30
          ),
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Estado",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Lato",
                    fontSize: 14
                ),
              ),
              Text(
                Task.stateToString(widget.state),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              )
            ],
          ),
        )
    );

    return Container(
      child: Row(
        children: [
          backButton,
          Container(
            height: 60,
            width: 1,
            decoration: BoxDecoration(
                color: Colors.white
            ),
          ),
          Expanded(
            child: state,
          )
        ],
      ),

      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.blue
      ),
    );
  }
}
