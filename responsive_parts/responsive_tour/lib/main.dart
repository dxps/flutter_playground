import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    scrollBehavior: CustomScrollBehavior(),

    title: 'Responsive Tour',
    theme: ThemeData(
      colorSchemeSeed: Colors.green,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 24)),
    ),

    home: const HomePage(),
  );
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
