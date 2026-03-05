import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Responsive UI - Basics (using MediaQuery)',
    theme: ThemeData(
      colorSchemeSeed: Colors.green,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 24)),
    ),
    home: const HomePage(),
  );
}
