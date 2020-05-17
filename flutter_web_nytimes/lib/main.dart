import 'dart:convert';

import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

Future<bool> configIsLoaded;
String apiKey;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //
    configIsLoaded = _loadConfig(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web NYTimes',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }

  Future<bool> _loadConfig(BuildContext context) async {
    var rootBundle = DefaultAssetBundle.of(context);
    var config = await rootBundle.loadString('assets/config.json');
    apiKey = jsonDecode(config)["api_key"];
    print(">>> Config is loaded.");
    return true;
  }

  //
}
