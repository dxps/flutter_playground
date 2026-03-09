import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../consts.dart';
import '../data/places.dart';
import '../model/place.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/place_details_widget.dart';
import '../widgets/place_gallery_widget.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  final String placeId;

  const HomePage({super.key, this.placeId = '1'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Place selectedPlace;

  @override
  void initState() {
    super.initState();
    selectedPlace = allPlaces.firstWhere((place) => place.id == widget.placeId);
    debugPrint("[_HomePageState] inited selectedPlace: id='${selectedPlace.id}' title='${selectedPlace.title}'");
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.placeId != widget.placeId) {
      _syncSelectedPlace();
      debugPrint("[_HomePageState] updated selectedPlace: id='${selectedPlace.id}' title='${selectedPlace.title}'");
    }
  }

  void _syncSelectedPlace() {
    selectedPlace = allPlaces.firstWhere((place) => place.id == widget.placeId, orElse: () => allPlaces.first);
  }

  void changePlace(Place place) {
    setState(() => selectedPlace = place);
    context.go('/places/${place.id}');
    debugPrint(
      "[_HomePageState.changePlace] updated selectedPlace: id='${selectedPlace.id}' title='${selectedPlace.title}'",
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Tour'), backgroundColor: grayColor),
      drawer: isMobile ? const Drawer(child: DrawerWidget()) : null,
      backgroundColor: Colors.grey[200],
      body: ResponsiveWidget(mobile: buildMobile(), tablet: buildTablet(), desktop: buildDesktop()),
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
        Expanded(child: PlaceGalleryWidget(onPlaceChanged: changePlace, isHorizontal: true)),
        Expanded(flex: 2, child: PlaceDetailsWidget(place: selectedPlace)),
      ],
    ),
  );
}
