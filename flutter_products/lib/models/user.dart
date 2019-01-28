import 'package:flutter/material.dart';

//
class User {
  //

  final String id;
  final String email;
  final String password;

  User({
    @required this.id,
    @required this.email,
    @required this.password,
  });

  String toJsonString() {
    return '{ "id":"$id", "email":"$email", "password":"$password" }';
  }
}
