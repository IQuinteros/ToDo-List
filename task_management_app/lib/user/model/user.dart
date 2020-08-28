import 'package:flutter/material.dart';
import 'package:task_management_app/bloc/user_bloc.dart';
import 'package:task_management_app/task/model/task.dart';

class UserNames{
  final String name;
  final String lastName;

  UserNames(this.name, this.lastName);
}

class User
{
  static User currentUser;
  static get getCurrentUser => currentUser;
  static setCurrentUser (User newUser, bool overwrite) {
    if(overwrite){
      currentUser = newUser;
    }
    else {
      if (currentUser == null) {
        currentUser = newUser;
      }
    }

    print("NEW USER: ${currentUser.email} ${currentUser.photoUrl}");
  }
  static clearCurrentUser() => currentUser = null;

  static Future<User> snapshotToUser(AsyncSnapshot snapshot, {bool isCurrentUser = true, @required UserBloc userBloc}) async {
    User user = User(
      id: snapshot.data.uid,
      photoUrl: snapshot.data.photoUrl,
      email: snapshot.data.email,
      displayName: snapshot.data.displayName
    );

    userBloc.getUserNames(user).then((value) {
      user.firstName = value.name;
      user.lastName = value.lastName;

      if(isCurrentUser){
        setCurrentUser(user, true);
      }
    });

    if(isCurrentUser){
      setCurrentUser(user, true);
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