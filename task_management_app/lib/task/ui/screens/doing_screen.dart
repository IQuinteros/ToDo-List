import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/no_tasks.dart';
import 'package:task_management_app/task/ui/widgets/task_in_list.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/loading.dart';
import 'package:task_management_app/user/model/user.dart';

class DoingScreen extends StatefulWidget {

  @override
  _DoingScreenState createState() => _DoingScreenState();
}

class _DoingScreenState extends State<DoingScreen> {

  UserBloc userBloc;
  User user;
  bool isEmpty = false;

  Widget listToDisplay(AsyncSnapshot snapshot){
    List<Task> tasks = Task.getTasksFromSnapshot(snapshot.data.documents);
    List<TaskInList> tasksInList = List();

    tasks.forEach((element) {
      tasksInList.add(TaskInList(
        task: element,
      ));
    });

    return ListView(
      children: tasksInList,
    );
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    user = User.getCurrentUser;


    final finalToDisplay = Stack(
      children: [
        BackgroundGradient(
          maxOpacity: 0.2,
        ),
        BackgroundTexture(
          opacity: 0.2,
        ),
        Container(
          margin: EdgeInsets.only(
              top: 10, bottom: 10
          ),
          child: StreamBuilder(
            stream: userBloc.myDoingTasksListStream(user.id),
            builder: (BuildContext ct, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Loading();
              }
              else if(snapshot.connectionState == ConnectionState.none){
                return Loading();
              }
              else if(snapshot.data.documents.length <= 0 || snapshot.hasError){
                return NoTasks();
              }
              else{
                return listToDisplay(snapshot);
              }
            },
          ),
        ),
      ],
    );

    return MainScaffold(
      titleText: "En Desarrollo",
      body: finalToDisplay,
      actionLocation: isEmpty? FloatingActionButtonLocation.centerFloat : FloatingActionButtonLocation.endFloat,
      bottomMargin: isEmpty? 40.0 : 0.0,
    );
  }
}
