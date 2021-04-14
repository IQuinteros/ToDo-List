import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
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

  // TODO: Agregar el sistema de Añadir la tarea

  bool moreOptionsOpen = false;
  UserBloc userBloc;

  bool _taskValid(){
    return widget.toAdd != null;
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  // DATA TO ADD
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  DateTime dateTime = DateTime.now();
  TaskState state;
  String color;

  void _validateInputs() async {
    if(_formKey.currentState.validate()){

      Task newData;

      if(detail.value.text == null){
        detail.text = "";
      }

      if(widget.toAdd == null) {
        newData = Task(
          name: title.value.text,
          detail: detail.value.text,
          finishDate: dateTime,
          status: state,
          color: color,
        );
        await userBloc.updateTask(newData);
      }
      else{
        newData = Task(
          id: widget.toAdd.id,
          name: title.value.text,
          detail: detail.value.text,
          finishDate: dateTime,
          status: state,
          color: color,
        );

        await userBloc.setDataTask(newData);
      }

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

    userBloc = BlocProvider.of<UserBloc>(context);

    state = widget.toAdd != null? widget.toAdd.status : TaskState.ToDo;
    color = widget.toAdd != null? widget.toAdd.color : "blue";

    if(_taskValid()){
      title.text = widget.toAdd.name;
      detail.text = widget.toAdd.detail;
    }
    else{
      title.text = "";
      detail.text = "";
    }

    final toDisplay = Container(
      child: Form(
        autovalidate: _autoValidate,
        key: _formKey,
        child: ListView(
          children: [
            TaskTitleInput(controller: title,),
            DescriptionTaskInput(controller: detail,),
            TaskDateInput(enabled: true, initialDate: _taskValid()? widget.toAdd.finishDate : DateTime.now(), onNewDate: (DateTime newDateTime) { print('NewDate'); dateTime = newDateTime; },),
            MoreOptions(task: widget.toAdd, isOpen: moreOptionsOpen, onOpenTap: () => moreOptionsOpen = !moreOptionsOpen,
              onNewColor: (String newColor) { print('NewColor'); color = newColor;},
              onNewStatus: (TaskState newState) {print('NewStatus');  state = newState;},
            )
          ],
        ),
      )
    );

    final bottomBtn = RaisedButton(
      color: Colors.blue,
      onPressed: () {
        _validateInputs();
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

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_taskValid()? "Modificar Tarea" : "Añadir Tarea"),
          shadowColor: Colors.blue,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () async {
              await _onBackPressed();
            },
          ),
        ),
        body: design,
      ),
    );
  }



  Future<bool> _onBackPressed() {
    if(title.text.length <= 0 && detail.text.length <= 0){
       Navigator.of(context).pop(true);
       return Future.value(true);
    }

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Salir sin Guardar'),
        content: new Text('No has guardado los cambios'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("SIN GUARDAR"),
            ),
          ),
          SizedBox(height: 16),
          new RaisedButton(
            onPressed: () {
              _validateInputs();
              Navigator.of(context).pop(true);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("GUARDAR"),
            ),
            color: Colors.blue,
          ),
        ],
      ),
    ) ??
        false;
  }
}
