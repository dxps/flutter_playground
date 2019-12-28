import 'package:flutter/material.dart';

class IconsPage extends StatelessWidget {
  const IconsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Icons')),
        body: Center(
          child: const Text('Icons'),
        ),
      ),
    );
  }
}
