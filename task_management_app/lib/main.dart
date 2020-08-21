import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return MaterialApp(
      title: 'Organiza Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppHomePage(),
      debugShowCheckedModeBanner: false,  // No Debug
    );
  }
}
