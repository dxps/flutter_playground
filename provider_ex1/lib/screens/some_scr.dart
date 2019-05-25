import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';
import '../widgets/textdisplay_wdg.dart';
import '../widgets/textedit_wdg.dart';

///
///
class SomeScreen extends StatefulWidget {
  //

  @override
  _SomeScreenState createState() => _SomeScreenState();

  //
}

///
///
class _SomeScreenState extends State<SomeScreen> {
  //

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: Text("SomeScreen with state")),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextDisplay(),
              TextEdit(Provider.of<AppState>(context).displayText),
            ],
          ),
        ),
      ),
    );
    //
  }

  //
}
