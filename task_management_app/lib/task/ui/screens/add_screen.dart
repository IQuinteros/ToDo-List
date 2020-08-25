import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/ui/widgets/description_task_input.dart';
import 'package:task_management_app/task/ui/widgets/more_options.dart';
import 'package:task_management_app/task/ui/widgets/task_date_input.dart';
import 'package:task_management_app/task/ui/widgets/task_title_input.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';

class AddScreen extends StatefulWidget {

  Task toAdd;

  AddScreen({
    @required this.toAdd
  });

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  bool _taskValid(){
    return widget.toAdd != null;
  }

  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  void _validateInputs(){
    if(_formKey.currentState.validate()){
      Navigator.of(context).pop();

      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Tarea agregada exitósamente"),
          )
      );
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
            TaskTitleInput(preText: _taskValid()? widget.toAdd.name : "",),
            DescriptionTaskInput(preText: _taskValid()? widget.toAdd.detail : "",),
            TaskDateInput(enabled: true,),
            MoreOptions()
          ],
        ),
      )
    );

    final bottomBtn = RaisedButton(
      color: Colors.blue,
      onPressed: () => {
        _validateInputs()
      },
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
        title: Text(_taskValid()? "Modificar Tarea" : "Añadir Tarea"),
        shadowColor: Colors.blue,
      ),
      body: design,
    );
  }
}
