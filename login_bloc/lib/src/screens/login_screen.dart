import 'package:flutter/material.dart';

import '../blocs/bloc.dart';

//
class LoginScreen extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          SizedBox(height: 20.0),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    //
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'you@mail.com', labelText: 'Email', errorText: snapshot.error),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    //
    return StreamBuilder(
      stream: bloc.password,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password', labelText: 'Password', errorText: snapshot.error),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton() {
    //
    return OutlineButton(
      child: Text('Login'),
      onPressed: () {},
    );
  }
}
