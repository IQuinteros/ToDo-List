import 'package:flutter/material.dart';
import 'package:task_management_app/task/ui/widgets/floating_add_task.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';

class MainScaffold extends StatelessWidget {

  final titleText;
  final Widget body;

  MainScaffold({
    @required this.titleText,
    @required this.body
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titleText),
          shadowColor: Colors.blue,
        ),
        drawer: SideMenu(),
        body: body,
        floatingActionButton: FloatingAddTask()
    );
  }
}
