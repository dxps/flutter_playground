import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_setup_1/core/models/user.dart';
import 'package:provider_setup_1/core/services/auth_svc.dart';
import 'package:provider_setup_1/ui/router.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      builder: (context) => locator<AuthenticationService>().userController,
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
  //
}
