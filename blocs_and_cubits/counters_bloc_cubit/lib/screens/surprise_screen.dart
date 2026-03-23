import 'package:flutter/material.dart';

class SurpriseScreen extends StatelessWidget {
  const SurpriseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Surprise! :)"), SizedBox(height: 16), BackButton()],
      ),
    );
  }
}
