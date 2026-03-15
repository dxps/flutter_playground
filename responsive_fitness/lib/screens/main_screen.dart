import 'package:flutter/material.dart';

import '../widgets/side_menu_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SideMenuWidget(),
            ),
            Expanded(
              flex: 7,
              child: Container(color: Colors.blue),
            ),
            Expanded(
              flex: 3,
              child: Container(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
