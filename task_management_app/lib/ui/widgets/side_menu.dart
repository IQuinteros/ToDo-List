import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/ui/screens/home_screen.dart';
import 'package:task_management_app/task/ui/screens/todo_screen.dart';
import 'package:task_management_app/ui/app_home_page.dart';
import 'package:task_management_app/ui/widgets/bottom_zeak_text.dart';
import 'package:task_management_app/user/model/user.dart';
import 'package:task_management_app/user/ui/screens/user_profile_screen.dart';

class SideMenu extends StatelessWidget {

  final IMAGE_SIZE = 90.0;

  UserBloc userBloc;
  ZUser userRef = ZUser.getCurrentUser;

  Widget headerContentAsync(BuildContext context){
    final profileImage = Container(
      width: IMAGE_SIZE,
      height: IMAGE_SIZE,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(userRef.photoUrl),
              fit: BoxFit.cover
          ),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.blue,
                blurRadius: 4,
                offset: Offset(0,0)
            )
          ]
      ),
    );


    final nameText = Container(
        margin: EdgeInsets.only(
            top: 10
        ),
        child: Text(
          userRef.displayName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Lato",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        )
    );

    final editIcon = InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          )
      ),
    );

    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileImage,
              Expanded(
                  child: Container()
              ),
              editIcon
            ],
          ),
          nameText
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    final headerContent = headerContentAsync(context);

    final textStyle = TextStyle(
      fontFamily: "Lato",
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black87
    );

    final listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: 40,
              top: 10,
              bottom: 10
          ),
          child: Text(
            "Tareas",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: Colors.blue.withOpacity(0.5),
                fontSize: 16
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio', style: textStyle,),
          onTap: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment_late),
          title: Text('Por Hacer', style: textStyle,),
          onTap: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/todo', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('En Desarrollo', style: textStyle,),
          onTap: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/doing', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment_turned_in),
          title: Text('Terminados', style: textStyle,),
          onTap: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/done', (Route<dynamic> route) => false);
          },
        ),
      ],
    );

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: headerContent,
            decoration: BoxDecoration(
                color: Color.fromRGBO(10, 36, 99, 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5
                  )
                ]
            ),
          ),
          Expanded(
            child: listView,
          ),
          Container(
              margin: EdgeInsets.only(
                left: 40,
                top: 10
              ),
              child: Text(
                "Zeak Software v0.1",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Conthrax",
                    color: Colors.blue.withOpacity(0.8),
                    shadows: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          offset: Offset(0,1)
                      )
                    ]
                ),
              )
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10
            ),
            child: InkWell(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Cerrar Sesión'),
                      content: Text('¿Quiere cerrar sesión?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancelar'),
                          onPressed: (){

                            Navigator.of(context).pop();
                          },
                        ),
                        RaisedButton(
                          child: Text('Aceptar'),
                          onPressed: (){
                            userBloc.signOut();
                            ZUser.clearCurrentUser();
                            Navigator.of(context).pushNamedAndRemoveUntil('/init', (Route<dynamic> route) => false);

                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    );
                  }
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 20,
                    top: 10,
                    bottom: 10,
                    right: 20
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    Text(
                      "Cerrar Sesión",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
