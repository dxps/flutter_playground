import 'package:flutter/material.dart';

import '../data/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allStates.length,
      itemBuilder: (context, index) {
        return index == 0 ? buildHeader() : buildMenuItem(index);
      },
    );
  }

  Widget buildHeader() => DrawerHeader(
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/swat.jpg'),
      ),
    ),
    child: Container(
      alignment: AlignmentDirectional.bottomStart,
      child: Text(
        'Pakistan',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
  );

  Widget buildMenuItem(int index) => ListTile(
    leading: const Icon(Icons.location_city),
    title: Text(allStates[index - 1], style: TextStyle(fontSize: 22)),
  );
}
