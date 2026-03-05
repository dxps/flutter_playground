import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/place_gallery_widget.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Tour')),
      drawer: isMobile ? const Drawer(child: DrawerWidget()) : null,
      body: ResponsiveWidget(
        mobile: buildMobile(),
        tablet: buildTablet(),
        desktop: buildDesktop(),
      ),
    );
  }

  Widget buildMobile() => const PlaceGalleryWidget();

  Widget buildTablet() => Container(
    color: Colors.blue,
    child: const Center(child: Text('Tablet Screen')),
  );

  Widget buildDesktop() => Container(
    color: Colors.orange,
    child: const Center(child: Text('Desktop Screen')),
  );
}
