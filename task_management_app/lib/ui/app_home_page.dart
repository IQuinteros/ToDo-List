import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/ui/screens/add_screen.dart';
import 'package:task_management_app/task/ui/screens/home_screen.dart';
import 'package:task_management_app/ui/screens/start_screen.dart';
import 'package:task_management_app/ui/widgets/side_menu.dart';
import 'package:task_management_app/user/model/user.dart';
import 'package:task_management_app/user/ui/screens/user_login.dart';

class AppHomePage extends StatefulWidget {

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return _handleScreen();
  }

  Widget _handleScreen(){

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        print(snapshot.connectionState.toString());
        if(snapshot.connectionState == ConnectionState.waiting){
          // Loading Widget
          return Scaffold(
            body: StartScreen(),
          );
        }
        else if(snapshot.hasError || !snapshot.hasData){
          // Sign In Widget
          return Scaffold(
            body: UserLogin(),
          );
        }
        else{
          // Run MainPage
          User.snapshotToUser(snapshot, isCurrentUser: true);
          return HomeScreen();
        }
      },
    );
  }
}
