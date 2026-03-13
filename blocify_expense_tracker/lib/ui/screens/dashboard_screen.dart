import 'package:flutter/material.dart';

import '../../config/routes/app_routes.dart';
import '../../utils/constants.dart';
import 'home_screen.dart';
import 'stats_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavBarIndex = 0;
  final List<Widget> _pages = const [HomeScreen(), StatsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png", height: defaultIconSize),
            const SizedBox(width: 10.0),
            const Text("Blocify Expense Tracker"),
          ],
        ),
      ),
      body: _pages.elementAt(_currentNavBarIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavBarIndex,
        onTap: (index) => setState(() => _currentNavBarIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Stats"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTransaction);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
