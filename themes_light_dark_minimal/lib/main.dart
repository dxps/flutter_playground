import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/theme_ctrl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController();
  await themeController.loadTheme();

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Theme Persistence Demo',
          themeMode: themeController.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.indigo,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.indigo,
          ),
          home: HomeScreen(themeController: themeController),
        );
      },
    );
  }
}
