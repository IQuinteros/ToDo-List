import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/ui/screens/doing_screen.dart';
import 'package:task_management_app/task/ui/screens/done_screen.dart';
import 'package:task_management_app/task/ui/screens/home_screen.dart';
import 'package:task_management_app/task/ui/screens/todo_screen.dart';
import 'package:task_management_app/ui/app_home_page.dart';
import 'package:task_management_app/ui/screens/start_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/todo': (context) => ToDoScreen(),
        '/doing': (context) => DoingScreen(),
        '/done': (context) => DoneScreen()
      },
      title: 'Organiza Tareas',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.blue
          )
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.blue
        ),
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: AppHomePage(),
      //debugShowCheckedModeBanner: false,  // No Debug
    );

    return BlocProvider(
      bloc: UserBloc(),
      child: materialApp,
    );
  }
}
