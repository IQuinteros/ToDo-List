import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';

class GoogleButton extends StatefulWidget {
  bool loading = false;

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    final text = Text(
      "Continuar con Google",
      style: TextStyle(
        fontFamily: "Lato",
        fontSize: 25,
        color: Color.fromRGBO(10, 36, 99, 1),
        fontWeight: FontWeight.bold
      ),
    );

    final icon = Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10
      ),
      child: Icon(
        Icons.camera,
        size: 40,
      ),
    );

    final content = Container(
      child: Row(
        children: [
          icon,
          text
        ],
      )
    );

    final button = InkWell(
      onTap: (){
        setState(() {
          widget.loading = true;
        });
        print('Google');
        userBloc.signInAndUpdate().catchError((value) {
          setState(() {
            widget.loading = false;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            bottom: 10
        ),
        child: content,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 5
              )
            ]
        ),
      ),
    );

    final isLoading = Container(
      padding: EdgeInsets.only(
          top: 10,
          bottom: 10
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 5
            )
          ]
      ),
    );

    Widget toDisplay;

    if(widget.loading){
      toDisplay = isLoading;
    }else{
      toDisplay = button;
    }

    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10
      ),
      child: toDisplay
    );
  }
}
