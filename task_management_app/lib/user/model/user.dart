import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';

class User
{
  String id;
  String firstName;
  String lastName;
  String email;
  String photoUrl;
  String displayName;

  List<Task> myTasks;

  User({
    @required this.id,
    this.firstName,
    this.lastName,
    @required this.email,
    @required this.photoUrl,
    @required this.displayName,
    this.myTasks
  });
}