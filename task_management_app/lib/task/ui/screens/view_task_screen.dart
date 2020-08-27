import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_bottom.dart';
import 'package:task_management_app/task/ui/widgets/task_date_input.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';

class ViewTaskScreen extends StatelessWidget {
  Task task;

  ViewTaskScreen({
    @required this.task
  });

  @override
  Widget build(BuildContext context) {

    final upBanner = Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      decoration: BoxDecoration(
        color: task.getColor(),
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
        task.name,
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
        task.detail,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen(toAdd: task,)));
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

    final screenStructure = Column(
      children: [
        upBanner,
        title,
        Expanded(
          child: ListView(
            children: [
              description,
              TaskDateInput(enabled: false, initialDate: task.finishDate,),
              buttonEdit
            ],
          ),
        ),
        TaskBottom(state: task.status, task: task,)
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
}
