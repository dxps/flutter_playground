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
      title: "SMC Tryout",
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
        title: Text("State Management Component"),
        backgroundColor: Colors.white24,
        elevation: 0.0,
      ),
      body: Center(
        child: StateBuilder(
          stateID: mainSmc.stateId,
          smcs: [mainSmc],
          builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Counter is:', style: Theme.of(context).textTheme.headline),
                  Text('${mainSmc.getCounter}', style: Theme.of(context).textTheme.display4),
                  Text(mainSmc.getErrorMsg, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 80),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        iconSize: 48.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: mainSmc.doIncrementCounter,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        iconSize: 48.0,
                        color: Colors.red,
                        onPressed: mainSmc.doDecrementCounter,
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
