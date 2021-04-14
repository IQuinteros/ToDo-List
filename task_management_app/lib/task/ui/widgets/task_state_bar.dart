import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/task_in_list.dart';
import 'package:task_management_app/ui/widgets/loading.dart';
import 'package:task_management_app/user/model/user.dart';

class TaskStateBarInList{

  final TaskState state;
  UserBloc userBloc;
  User user;
  BuildContext context;

  bool isExpanded = false;

  String title;

  TaskStateBarInList({
    @required this.state,
    this.isExpanded = false,
    this.context
  });

  Widget listDisplay(AsyncSnapshot snapshot){
    List<TaskInList> tasksInList = List();
    List<Task> tasks = Task.getTasksFromSnapshot(snapshot.data.documents);

    tasks.forEach((element) {
      tasksInList.add(TaskInList(
        task: element,
      ));
    });

    return Column(
        children: tasksInList
    );
  }

  ExpansionPanel build(){

    userBloc = BlocProvider.of<UserBloc>(context);
    user = User.getCurrentUser;

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

    final bar = DragTarget(
      builder: (BuildContext context, List<String> incoming, List rejected){
        return Container(
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
      },
      onWillAccept: (data) {
        print('willAccept');
        return true;
      },
      onAccept: (data){
        print('hola');
      },
    );

    Widget loading = Container(
      padding: EdgeInsets.all(10),
      child: Loading(),
    );

    Widget listTasks;

    if(isExpanded){
      listTasks = Container(
          margin: EdgeInsets.only(
              top: 5,
              bottom: 10
          ),
          child: StreamBuilder(
            stream: state == TaskState.ToDo? userBloc.myToDoTasksListStream(user.id) :
            state == TaskState.Doing? userBloc.myDoingTasksListStream(user.id) :
            userBloc.myDoneTasksListStream(user.id),
            builder: (BuildContext ct, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return loading;
              }
              else if(snapshot.connectionState == ConnectionState.none){
                return loading;
              }
              else if(snapshot.data.documents.length <= 0 || snapshot.hasError){
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "No hay tareas aquí",
                    style: TextStyle(
                      color: Color.fromRGBO(10, 36, 99, 1),
                      fontFamily: "Lato",
                      fontSize: 14,
                    ),
                  ),
                );
              }
              else{
                return listDisplay(snapshot);
              }
            },
          )
      );
    }
    else{
      listTasks = Container();
    }

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

