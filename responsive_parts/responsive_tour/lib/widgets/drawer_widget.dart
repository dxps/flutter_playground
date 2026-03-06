import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../data/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.02;

    return ListView.builder(
      itemCount: allStates.length,
      itemBuilder: (context, index) {
        return index == 0
            ? buildHeader(fontSize)
            : buildMenuItem(index, fontSize);
      },
    );
  }

  Widget buildHeader(double fontSize) => DrawerHeader(
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/swat.jpg'),
      ),
    ),
    child: Container(
      alignment: AlignmentDirectional.bottomStart,
      child: AutoSizeText(
        'Pakistan',
        minFontSize: 22,
        maxFontSize: 30,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    ),
  );

  Widget buildMenuItem(int index, double fontSize) => ListTile(
    leading: const Icon(Icons.location_city),
    title: AutoSizeText(
      allStates[index - 1],
      minFontSize: 13,
      maxFontSize: 26,
      style: TextStyle(fontSize: fontSize),
    ),
  );
}
