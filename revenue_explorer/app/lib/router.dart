import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revenue_explorer/pages/detail.page.dart';
import 'package:revenue_explorer/pages/overview.page.dart';
import 'package:revenue_explorer/pages/profile.page.dart';

final revexRouter = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    redirect: (_, __) => '/overview',
  ),
  GoRoute(
    path: '/overview',
    pageBuilder: (context, state) => const MaterialPage(
      child: RevExOverviewPage(),
    ),
  ),
  GoRoute(
    path: '/detail/:columnName/:columnValue',
    name: 'detail',
    pageBuilder: (context, state) => MaterialPage(
      child: RevExDetailPage(
        filterColumnName: state.params['columnName']!,
        filterColumnValue: state.params['columnValue']!,
      ),
    ),
  ),
  GoRoute(
    path: '/profile',
    pageBuilder: (context, state) => const MaterialPage(
      child: RevExProfilePage(),
    ),
  ),
]);
