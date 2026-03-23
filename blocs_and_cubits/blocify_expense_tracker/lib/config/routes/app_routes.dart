import 'package:flutter/material.dart';

import '../../ui/screens/add_transaction_screen.dart';
import '../../ui/screens/dashboard_screen.dart';

class AppRoutes {
  static const String dashboard = "/";
  static const String addTransaction = "/add-transaction";
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case AppRoutes.addTransaction:
        return MaterialPageRoute(
          builder: (_) => const AddTransactionScreen(),
          // fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Center(
            child: Text("Something went wrong!\nScreen not found for route\n'${settings.name}'."),
          ),
        );
    }
  }
}
