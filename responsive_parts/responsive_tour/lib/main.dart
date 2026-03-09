import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: '/', redirect: (context, state) => '/places/1'),
    GoRoute(
      path: '/places/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return HomePage(placeId: id);
      },
    ),
  ],
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    scrollBehavior: CustomScrollBehavior(),

    title: 'Responsive Tour',
    theme: ThemeData(
      colorSchemeSeed: Colors.green,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 24)),
    ),

    routerConfig: _router,
  );
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
