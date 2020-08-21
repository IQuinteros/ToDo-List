import 'package:flutter/material.dart';

class User
{
  String id;
  String firstName;
  String lastName;
  String email;
  String photoUrl;
  String displayName;

  User({
    @required this.id,
    this.firstName,
    this.lastName,
    @required this.email,
    @required this.photoUrl,
    @required this.displayName
  });
}