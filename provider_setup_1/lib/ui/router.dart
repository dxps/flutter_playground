import 'package:flutter/material.dart';
import 'package:provider_setup_1/core/models/post.dart';
import 'package:provider_setup_1/ui/views/home_view.dart';

import 'views/login_view.dart';
import 'views/post_view.dart';

/// The app's routes.
class Router {
  //
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(body: Center(child: Text('Route \'${settings.name}\' is unknown.')));
        });
    }
  }
  //
}
