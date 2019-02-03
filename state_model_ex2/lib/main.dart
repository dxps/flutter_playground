import 'package:flutter/material.dart';
import 'dart:math';
import './src/states/state_builder.dart';
import './src/states/main_state.dart';

void main() => runApp(
      //
      StateBuilder(
        initState: (_) => mainState = MainState(),
        dispose: (_) => mainState = null,
        builder: (_) => AppRoot(),
      ),
      //
    );

///
class AppRoot extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      title: 'StateModel - ex2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen, splashColor: Colors.lightGreen),
      home: HomeScreen(title: 'StateModel - ex2'),
    );
  }

  //
}

///
class HomeScreen extends StatelessWidget {
  //

  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0.0,
        backgroundColor: Colors.white24,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => mainState.fetchList(stateId: mainState.stateId),
          )
        ],
      ),
      body: StateBuilder(
        stateId: mainState.stateId,
        usingStates: [mainState],
        initState: (state) => mainState.fetchList(state: state),
        builder: (_) => Center(
              child: mainState.isLoadingItems
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: mainState.items.length,
                      itemBuilder: (state, index) => StateBuilder(
                            builder: (state) => ListTile(
                                  title: Text("Item number ${Random().nextInt(100)}"),
                                  trailing: Text("${mainState.items[index]}"),
                                  onTap: () => mainState.decrement(index, state),
                                ),
                          ),
                    ),
            ),
      ),
    );
  }

  //
}
