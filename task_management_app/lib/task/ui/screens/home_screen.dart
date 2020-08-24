import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';
import 'package:task_management_app/task/ui/widgets/floating_add_task.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_state_bar.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = ListView(
      children: [
        TaskStateBar(
          state: TaskState.ToDo,
        ),
        TaskStateBar(
          state: TaskState.Doing,
          isOpen: true,
        ),
        TaskStateBar(
          state: TaskState.Done,
        )
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
        list
      ],
    );

    final scaffold = MainScaffold(
      titleText: "Tareas",
      body: finalToDisplay,
    );

    return scaffold;
  }
}
