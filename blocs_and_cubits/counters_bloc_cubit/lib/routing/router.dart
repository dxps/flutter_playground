import 'package:counters_bloc_cubit/screens/surprise_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/layout_scaffold.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final cubitRoute = Routes.cubitRoute;
final blocRoute = Routes.blocRoute;

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.counterCubit,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: cubitRoute.path,
              builder: (context, state) => cubitRoute.screen,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: blocRoute.path,
              builder: (context, state) => blocRoute.screen,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/surprise',
              builder: (context, state) => const SurpriseScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
