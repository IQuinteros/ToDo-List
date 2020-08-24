import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final design = Stack(
      children: [
        BackgroundGradient(
          maxOpacity: 0.2,
        ),
        BackgroundTexture(
          opacity: 0.2,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir Tarea"),
        shadowColor: Colors.blue,
      ),
      body: design,
    );
  }
}
