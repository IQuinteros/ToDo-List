import 'package:flutter/material.dart';
import 'package:task_management_app/task/ui/widgets/main_scaffold.dart';
import 'package:task_management_app/task/ui/widgets/task_in_list.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';

class DoingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = ListView(
      children: [
        TaskInList(),
        TaskInList(),
        TaskInList()
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
      titleText: "En Desarrollo",
      body: finalToDisplay,
    );
  }
}
