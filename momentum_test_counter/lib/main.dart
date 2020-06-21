import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './counter/counter_cm.dart';

void main() {
  runApp(
    Momentum(
      child: MyApp(),
      controllers: [CounterController()],
      persistSave: (context, key, value) async {
        print(">>> persistSave > Saving key:value=$key:$value");
        var sharedPrefs = await SharedPreferences.getInstance();
        return await sharedPrefs.setString(key, value);
      },
      persistGet: (context, key) async {
        var sharedPrefs = await SharedPreferences.getInstance();
        var value = sharedPrefs.getString(key);
        print(">>> persistGet > For key=$key, got value=$value");
        return value;
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum (State Mgmt) Counter Demo',
      theme: ThemeData(primarySwatch: Colors.green, visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomeWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeWidget extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Momentum Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You clicked this many times:'),
            MomentumBuilder(
              controllers: [CounterController],
              builder: (context, snapshot) {
                var counterModel = snapshot<CounterModel>();
                return Text('${counterModel.value}', style: Theme.of(context).textTheme.headline4);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: Momentum.controller<CounterController>(context).increment,
        tooltip: 'Increment',
      ),
    );
  }
  //
}
