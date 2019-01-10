import 'package:flutter/material.dart';

import './blocs/provider.dart';
import './screens/login_screen.dart';

//
class App extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Log Me In',
        home: Scaffold(body: LoginScreen()),
      ),
    );
  }
}
