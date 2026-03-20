import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/layout_scaffold.dart';
import '../models/user.dart';
import '../pages/explore_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homePage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.explorePage,
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingsPage,
              builder: (context, state) => const SettingsPage(),
              routes: [
                GoRoute(
                  path: Routes.profilePage,
                  builder: (context, state) {
                    final user = state.extra as User?;
                    return ProfilePage(user: user);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
