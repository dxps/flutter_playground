import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth_pg.dart';
import './pages/products_pg.dart';
import './pages/product_pg.dart';
import './pages/prods_admin_pg.dart';
import './scoped_models/main.dart';

void main() {
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

//
class MyApp extends StatefulWidget {
  //

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//
class _MyAppState extends State<MyApp> {
  //

  @override
  Widget build(BuildContext context) {
    //
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepOrange,
            buttonTheme: ButtonThemeData(buttonColor: Colors.deepOrange, textTheme: ButtonTextTheme.normal)
            // fontFamily: 'Oswald',
            ),
        debugShowCheckedModeBanner: false, // hide 'debug' label
        //home: AuthPage(),
        routes: {
          // Named Routes
          '/': (BuildContext ctx) => AuthPage(),
          '/home': (BuildContext ctx) => ProductsPage(),
          '/admin': (BuildContext ctx) => ProductsAdminPage(),
        },
        onGenerateRoute: (RouteSettings routeSettings) {
          //
          // Route: /products/id
          //
          final List<String> pathElements = routeSettings.name.split('/');
          if (pathElements[0] != '') return null; // since the path does not starts with '/'.
          if (pathElements[1] == 'products') {
            int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings routeSettings) {
          // We get here if both named and generated routes could not be retrieved.
          debugPrint('[_MyAppState] onUnknownRoute > Returning the home.');
          return MaterialPageRoute(builder: (BuildContext ctx) => ProductsPage());
        },
      ),
    );
  }
}
