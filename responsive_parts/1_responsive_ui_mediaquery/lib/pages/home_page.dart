import 'package:flutter/material.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ResponsiveWidget(
          mobile: buildMobile(),
          tablet: buildTablet(),
          desktop: buildDesktop(),
        ),
      );

  Widget buildMobile() => Container(
        color: Colors.red,
        child: const Center(child: Text('Mobile Screen')),
      );

  Widget buildTablet() => Container(
        color: Colors.blue,
        child: const Center(child: Text('Tablet Screen')),
      );

  Widget buildDesktop() => Container(
        color: Colors.orange,
        child: const Center(child: Text('Desktop Screen')),
      );
}
