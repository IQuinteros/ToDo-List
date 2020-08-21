import 'package:flutter/material.dart';

enum TaskState{
  ToDo,
  Doing,
  Done
}

class Task
{
  String id;
  String name;
  String detail;
  String finishDate;
  String userOwner;
  TaskState status;
  String color;

  Task({
    @required this.id,
    @required this.name,
    this.detail,
    this.finishDate,
    @required this.userOwner,
    @required this.status,
    this.color
  });
}