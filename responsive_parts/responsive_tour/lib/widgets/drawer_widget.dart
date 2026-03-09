import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../data/states.dart';

class DrawerWidget extends StatelessWidget {
  final String? state;
  final ValueChanged<String> onStateChanged;

  const DrawerWidget({super.key, this.state, required this.onStateChanged});

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.02;

    return ListView.builder(
      itemCount: allStates.length,
      itemBuilder: (context, index) {
        return index == 0 ? buildHeader(fontSize) : buildMenuItem(index, fontSize);
      },
    );
  }

  Widget buildHeader(double fontSize) => DrawerHeader(
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      image: DecorationImage(fit: BoxFit.cover, image: AssetImage('images/swat.jpg')),
    ),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(120),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
        ),
        child: AutoSizeText(
          'Pakistan',
          minFontSize: 22,
          maxFontSize: 30,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    ),
  );

  Widget buildMenuItem(int index, double fontSize) {
    final stateName = allStates[index - 1];
    final isSelected = state != null && state == stateName;
    final borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: isSelected ? Colors.grey.withAlpha(160) : Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          hoverColor: Colors.grey.withAlpha(45),
          leading: Icon(Icons.location_city, color: isSelected ? Colors.green : null),
          title: AutoSizeText(
            stateName,
            minFontSize: 13,
            maxFontSize: 26,
            style: TextStyle(fontSize: fontSize, color: isSelected ? Colors.white : null),
          ),
          onTap: () {
            onStateChanged(stateName);
          },
        ),
      ),
    );
  }
}
