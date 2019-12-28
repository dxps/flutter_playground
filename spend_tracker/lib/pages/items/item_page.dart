import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Item')),
        body: Center(
          child: const Text('Item'),
        ),
      ),
    );
  }
}
