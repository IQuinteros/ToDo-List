import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_in_list.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';

class DoneScreen extends StatelessWidget {

  // TODO: Agregar el sistema de "Ver tareas DONE"
  @override
  Widget build(BuildContext context) {
    final list = ListView(
      children: [
        TaskInList(task: Task.generateRandomTask()),
        TaskInList(task: Task.generateRandomTask()),
        TaskInList(task: Task.generateRandomTask())
      ],
    );

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
          child: list,
        ),
      ],
    );

    return MainScaffold(
      titleText: "Terminados",
      body: finalToDisplay,
    );
  }
}
