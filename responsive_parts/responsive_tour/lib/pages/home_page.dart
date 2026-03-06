import 'package:flutter/material.dart';
import 'package:responsive_tour/consts.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/place_gallery_widget.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Tour'),
        backgroundColor: grayColor,
      ),
      drawer: isMobile ? const Drawer(child: DrawerWidget()) : null,
      backgroundColor: Colors.grey[200],
      body: ResponsiveWidget(
        mobile: buildMobile(),
        tablet: buildTablet(),
        desktop: buildDesktop(),
      ),
    );
  }

  Widget buildMobile() => const PlaceGalleryWidget();

  Widget buildTablet() => Row(
    children: [
      Expanded(flex: 2, child: DrawerWidget()),
      Expanded(flex: 5, child: PlaceGalleryWidget()),
    ],
  );

  Widget buildDesktop() => Container(
    color: Colors.orange,
    child: const Center(child: Text('Desktop Screen')),
  );
}
