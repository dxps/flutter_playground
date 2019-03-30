import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/home_scr.dart';

void main() => runApp(MyApp());

///
///
///
class MyApp extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      title: 'Flutter Reorderable List',
      theme: ThemeData(dividerColor: Color(0x50000000), primarySwatch: Colors.blueGrey),
      home: HomeScreen(title: 'Flutter Reorderable List'),
    );
    //
  }

  //
}
