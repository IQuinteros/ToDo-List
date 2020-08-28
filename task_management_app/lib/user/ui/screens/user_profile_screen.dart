import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/user/model/user.dart';
import 'package:task_management_app/user/ui/widgets/user_name_input.dart';

class UserProfileScreen extends StatefulWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final keyForm = GlobalKey<FormState>();

  User initUser;

  UserProfileScreen();

  @override
  _UserProfileScreenState createState() {
    initUser = User.getCurrentUser;

    nameController.text = initUser.firstName;
    lastNameController.text = initUser.lastName;

    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _autoValidate = false;

  UserBloc userBloc;
  User user;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);
    user = User.getCurrentUser;

    final button = IconButton(
      icon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      onPressed: ()async{
        if(widget.keyForm.currentState.validate()){
          await userBloc.updateUserNames(widget.nameController.value.text,
              widget.lastNameController.value.text,
              user.id);
          await userBloc.getCurrentUser();

          Navigator.of(context).pop();
        }
        else{
          setState(() {
            _autoValidate = true;
          });
        }

      },
      color: Colors.blue,
    );

    final list = ListView(
      children: [
        UserNameInput(hintText: "Nombres", warningText: "Ingresa tus Nombres", controller: widget.nameController,),
        UserNameInput(hintText: "Apellidos", warningText: "Ingresa tus Apellidos", controller: widget.lastNameController,),
        Container(
          margin: EdgeInsets.only(
              top: 100
          ),
          child: Ink(
            decoration: const ShapeDecoration(
              color: Colors.lightBlue,
              shape: CircleBorder(),
              shadows: <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                  offset: Offset(0,1)
                )
              ]
            ),
            width: 60,
            height: 60,
            child: button,
          ),
        ),
      ],
    );

    final toDisplay = Stack(
      children: [
        BackgroundGradient(
          maxOpacity: 0.4,
        ),
        BackgroundTexture(
          opacity: 0.4,
        ),
        Form(
          key: widget.keyForm,
          child: list,
          autovalidate: _autoValidate,
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
        shadowColor: Colors.blue,
      ),
      body: toDisplay
    );
  }
}
