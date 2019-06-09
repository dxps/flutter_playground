import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_scr.dart';
import './states/app_state.dart';
import './states/counter.dart';

void main() => runApp(MyApp());

/// The root of this app.
class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(builder: (_) => AppState()),
        ChangeNotifierProvider<Counter>(builder: (_) => Counter(0)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
    //
  }
  //
}
