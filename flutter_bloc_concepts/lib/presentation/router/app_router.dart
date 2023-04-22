import 'package:flutter/material.dart';
import 'package:flutter_bloc_concepts/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/third_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    debugPrint("onGeneratedRoute > settings name=${settings.name} arguments=${settings.arguments}");

    // settings.arguments is null initially and when going to 3rd screen.
    final GlobalKey<ScaffoldState> key =
        (settings.arguments == null) ? GlobalKey<ScaffoldState>() : settings.arguments! as GlobalKey<ScaffoldState>;

    switch (settings.name) {
      case '/':
        return _getHomeScreenRoute();

      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.redAccent,
            homeScreenKey: key,
          ),
        );

      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Third Screen",
            color: Colors.greenAccent,
          ),
        );

      default:
        return _getHomeScreenRoute();
    }
  }

  Route _getHomeScreenRoute() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(title: "Home Screen", color: Colors.blueAccent),
    );
  }
}
