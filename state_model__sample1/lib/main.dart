import 'package:flutter/material.dart';
import './src/states/main_state.dart';
import './src/states/state_builder.dart';

void main() => runApp(
      StateBuilder(
        builder: (_) => MyApp(),
        initState: (_) => mainState = MainState(),
        dispose: (_) => mainState = null,
      ),
    );

///
class MyApp extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StateModel - sample 1",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
      appBar: AppBar(
        title: Text("StateModel - sample 1"),
        backgroundColor: Colors.white24,
        elevation: 0.0,
      ),
      body: Center(
        child: StateBuilder(
          stateId: mainState.stateId,
          usingStates: [mainState],
          builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Counter is:', style: Theme.of(context).textTheme.headline),
                  Text('${mainState.getCounter}', style: Theme.of(context).textTheme.display4),
                  Text(mainState.getErrorMsg, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 80),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        iconSize: 48.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: mainState.doIncrementCounter,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        iconSize: 48.0,
                        color: Colors.red,
                        onPressed: mainState.doDecrementCounter,
                      ),
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }

  //
}
