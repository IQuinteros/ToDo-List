import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';
import 'package:task_management_app/task/ui/widgets/floating_add_task.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_state_bar.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {

  // TODO: Agregar el sistema de "Ver tareas"

  List<TaskStateBarInList> _taskBars = List();

  @override
  _HomeScreenState createState() {
    _taskBars.add(
        TaskStateBarInList(
          state: TaskState.ToDo,
        )
    );
    _taskBars.add(
        TaskStateBarInList(
          state: TaskState.Doing,
        )
    );
    _taskBars.add(
        TaskStateBarInList(
          state: TaskState.Done,
        )
    );
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    List<ExpansionPanel> expansionPanels = List();

    widget._taskBars.forEach((element) {
      expansionPanels.add(element.build());
    });

    final list = ListView(
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded){
            setState(() {
              widget._taskBars[index].isExpanded = !isExpanded;
            });
          },
          children: expansionPanels,
          animationDuration: Duration(milliseconds: 500),
        ),
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
      body: finalToDisplay
    );

    return scaffold;
  }
}
