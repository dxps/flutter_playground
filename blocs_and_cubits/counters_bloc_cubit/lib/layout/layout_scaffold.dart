import 'package:counters_bloc_cubit/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: NavigationBar(
      backgroundColor: Colors.black26,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
      indicatorColor: Theme.of(context).primaryColor,
      destinations: Routes.all
          .map(
            (destination) => NavigationDestination(
              icon: Icon(destination.icon),
              label: destination.label,
              selectedIcon: Icon(destination.icon, color: Colors.white),
            ),
          )
          .toList(),
    ),
  );
}
