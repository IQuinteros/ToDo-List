import 'package:flutter/material.dart';
import 'package:task_management_app/task/ui/widgets/description_task_input.dart';
import 'package:task_management_app/task/ui/widgets/task_date_input.dart';
import 'package:task_management_app/task/ui/widgets/task_title_input.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';

class AddScreen extends StatefulWidget {

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  void _validateInputs(){
    if(_formKey.currentState.validate()){

    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final toDisplay = Container(
      child: Form(
        autovalidate: _autoValidate,
        key: _formKey,
        child: ListView(
          children: [
            TaskTitleInput(),
            DescriptionTaskInput(),
            TaskDateInput()
          ],
        ),
      )
    );

    final bottomBtn = RaisedButton(
      color: Colors.blue,
      onPressed: () => _validateInputs(),
      child: Container(
        margin: EdgeInsets.only(
          top: 13,
          bottom: 13
        ),
        child: Center(
          child: Text(
            "¡Listo!",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        ),
      )
    );

    final screenStructure = Column(
      children: [
        Expanded(
          child: toDisplay
        ),
        bottomBtn
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir Tarea"),
        shadowColor: Colors.blue,
      ),
      body: design,
    );
  }
}
