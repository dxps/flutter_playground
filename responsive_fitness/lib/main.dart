import 'package:flutter/material.dart';
import 'package:responsive_fitness/screens/main_screen.dart';
import 'package:responsive_fitness/utils/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const MainScreen(),
    );
  }
}
