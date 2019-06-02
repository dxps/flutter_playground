import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';

///
///
///
class TextDisplay extends StatefulWidget {
  //
  @override
  _TextDisplayState createState() => _TextDisplayState();
  //
}

class _TextDisplayState extends State<TextDisplay> {
  //
  @override
  Widget build(BuildContext context) {
    //
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(appState.displayText, style: TextStyle(fontSize: 24.0)),
    );
    //
  }
  //
}
