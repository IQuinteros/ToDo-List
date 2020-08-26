import 'package:flutter/material.dart';
import 'package:task_management_app/task/model/task.dart';

class User
{

  static User currentUser;
  static get getCurrentUser => currentUser;
  static setCurrentUser (User newUser) => {if(currentUser == null){currentUser = newUser}};
  static clearCurrentUser() => currentUser = null;

  static User snapshotToUser(AsyncSnapshot snapshot, {bool isCurrentUser = true}){

    User user = User(
      id: snapshot.data.uid,
      photoUrl: snapshot.data.photoUrl,
      email: snapshot.data.email,
      displayName: snapshot.data.displayName
    );

    if(isCurrentUser){
      setCurrentUser(user);
    }

    return user;
  }

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