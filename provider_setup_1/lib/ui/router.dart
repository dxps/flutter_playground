import 'package:flutter/material.dart';
import 'package:provider_setup_1/ui/views/home_view.dart';

import 'views/login_view.dart';
import 'views/post_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'post':
        return MaterialPageRoute(builder: (_) => PostView(post: settings.arguments));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(body: Center(child: Text('Route \'${settings.name}\' is unknown.')));
        });
    }
  }
}
