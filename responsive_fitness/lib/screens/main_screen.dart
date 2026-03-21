import 'package:flutter/material.dart';
import 'package:responsive_fitness/widgets/summary_widget.dart';

import '../widgets/dashboard_widget.dart';
import '../widgets/side_menu_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 2, child: SideMenuWidget()),
            Expanded(flex: 7, child: DashboardWidget()),
            Expanded(flex: 3, child: SummaryWidget()),
          ],
        ),
      ),
    );
  }
}
