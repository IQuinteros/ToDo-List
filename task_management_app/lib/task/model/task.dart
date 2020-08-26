import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  DateTime finishDate;
  String userOwner;
  TaskState status;
  String color;

  Task({
    this.id,
    @required this.name,
    this.detail,
    this.finishDate,
    this.userOwner,
    @required this.status,
    this.color
  });

  Color getColor(){
    switch(color){
      case 'red': return Colors.red;
      case 'yellow': return Colors.yellow;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      default: return Colors.blue;
    }
  }

  static List<Task> getTasksFromSnapshot(List<DocumentSnapshot> tasksSnapshot){
    List<Task> tasks = List();
    tasksSnapshot.forEach((element) {
      tasks.add(Task(
        id: element.documentID,
        name: element['name'],
        status: element['status'],
        userOwner: element['userOwner'].toString(),
        color: element['color'],
        finishDate: element['finishDate'],
        detail: element['detail']
      ));
    });

    return tasks;
  }

  static String stateToString(TaskState state){
    switch(state){
      case TaskState.ToDo:
        return "Por Hacer";
      case TaskState.Doing:
        return "En Desarrollo";
      case TaskState.Done:
        return "Terminado";
      default: return "";
    }
  }

  static Task generateRandomTask(){
    return Task(
      id: "random",
      name: "Título de Tarea " + Random().nextInt(500).toString(),
      detail: "Descripción Completa de la tarea, con multilínea, la cual es necesaria para ver si esto funciona correctamente",
      finishDate: DateTime.now().add(Duration(days: 4)),
      userOwner: null,
      status: Random().nextBool()? TaskState.ToDo : TaskState.Doing,
      color: Random().nextBool()? "red" : Random().nextBool()? "blue" : Random().nextBool()? "orange" : Random().nextBool()? "green" : "purple"
    );
  }

}