import 'package:flutter/material.dart';
import './src/smcs/main_smc.dart';

void main() => runApp(
      // SMCs are instantiated in the initState() of a stateful widget.

      StateBuilder(
        builder: (_) => MyApp(),
        initState: (_) => mainSmc = MainSmc(),
        dispose: (_) => mainSmc = null,
      ),
    );

///
class MyApp extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SetState management",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

///
class MyHomePage extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: Text("State Management")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StateBuilder(
              stateID: "CounterText",
              smcs: [mainSmc],
              builder: (_) => Text('${mainSmc.counter}', style: Theme.of(context).textTheme.display1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: mainSmc.doIncrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }

  //
}
