import 'package:flutter/material.dart';
import 'package:responsive_fitness/utils/responsive.dart';

import '../data/repos/side_menu_data.dart';
import '../utils/consts.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
      color: Responsive.isDesktop(context) ? backgroundColor : cardBackgroundColor,
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = currIndex == index;
    final color = isSelected ? Colors.black : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () => setState(() => currIndex = index),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(data.menu[index].icon, color: color),
            ),
            Text(data.menu[index].title, style: TextStyle(color: color, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
