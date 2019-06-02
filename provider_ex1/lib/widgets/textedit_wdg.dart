import 'package:flutter/material.dart';
import '../states/app_state.dart';
import 'package:provider/provider.dart';

///
///
class TextEdit extends StatefulWidget {
  //
  final String initialValue;

  TextEdit(String initialValue) : this.initialValue = initialValue;

  @override
  _TextEditState createState() => _TextEditState(initialValue);

  //
}

///
///
class _TextEditState extends State<TextEdit> {
  //

  TextEditingController _textEditingCtrl;

  _TextEditState(String initialValue) {
    _textEditingCtrl = TextEditingController(text: initialValue);
  }

  @override
  Widget build(BuildContext context) {
    //
    final appState = Provider.of<AppState>(context);
    return Container(
      child: TextField(
        controller: _textEditingCtrl,
        decoration: InputDecoration(labelText: "Some Text", border: OutlineInputBorder()),
        onChanged: (changed) => appState.setDisplayText(changed),
        onSubmitted: (submitted) => appState.setDisplayText(submitted),
      ),
    );
  }

  //
}
