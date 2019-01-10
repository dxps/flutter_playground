import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';

//
class LoginScreen extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    final bloc = Provider.of(context);
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          SizedBox(height: 20.0),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
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

  Widget passwordField(Bloc bloc) {
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

  Widget submitButton(Bloc bloc) {
    //
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        debugPrint('submitButton > snapshot.data=\'${snapshot.data}\'');
        return OutlineButton(
          child: Text('Login'),
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }
}
