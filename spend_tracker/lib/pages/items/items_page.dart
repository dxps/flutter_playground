import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Items')),
        body: Center(
          child: const Text('Items'),
        ),
      ),
    );
  }
}
