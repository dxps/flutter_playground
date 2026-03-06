import 'package:flutter/material.dart';
import 'package:responsive_tour/consts.dart';
import 'package:responsive_tour/data/places.dart';
import 'package:responsive_tour/model/place.dart';
import 'package:responsive_tour/widgets/place_details_widget.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/place_gallery_widget.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Place selectedPlace = allPlaces.first;
  void changePlace(Place place) => setState(() => selectedPlace = place);

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

  Widget buildMobile() => PlaceGalleryWidget(onPlaceChanged: changePlace);

  Widget buildTablet() => Row(
    children: [
      Expanded(flex: 2, child: DrawerWidget()),
      Expanded(flex: 5, child: PlaceGalleryWidget(onPlaceChanged: changePlace)),
    ],
  );

  Widget buildDesktop() => Row(
    children: [
      const Expanded(child: DrawerWidget()),
      Expanded(flex: 3, child: buildBody()),
    ],
  );

  Widget buildBody() => Container(
    color: grayColor,
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: [
        Expanded(
          child: PlaceGalleryWidget(
            onPlaceChanged: changePlace,
            isHorizontal: true,
          ),
        ),
        Expanded(flex: 2, child: PlaceDetailsWidget(place: selectedPlace)),
      ],
    ),
  );
}
