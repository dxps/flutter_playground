import 'package:counters_bloc_cubit/screens/counter_bloc_screen.dart';
import 'package:counters_bloc_cubit/screens/counter_cubit_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  final String path;
  final String label;
  final IconData icon;
  final Widget screen;

  static const String counterCubit = '/counter_cubit';
  static const String counterBloc = '/counter_bloc';

  Routes({required this.path, required this.label, required this.icon, required this.screen});

  static final List<Routes> all = [
    Routes(path: '/counter_cubit', label: "Counter Cubit", icon: Icons.home, screen: const CounterCubitScreen()),
    Routes(path: '/counter_bloc', label: "Counter BLoC", icon: Icons.business, screen: const CounterBlocScreen()),
  ];

  static Routes get cubitRoute => all[0];
  static Routes get blocRoute => all[1];
}
