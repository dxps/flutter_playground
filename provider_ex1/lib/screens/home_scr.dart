import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ex1/screens/some_scr.dart';
import '../states/counter.dart';

///
/// The home screen.
///
class HomeScreen extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    final counter = Provider.of<Counter>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Provider Demo")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text('${counter.getValue()}', style: Theme.of(context).textTheme.display1),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.add),
              onPressed: counter.increment,
              tooltip: 'Increment',
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.remove),
              onPressed: counter.decrement,
              tooltip: 'Decrement',
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.storage),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => SomeScreen())),
            ),
          ],
        ));
  }
}
