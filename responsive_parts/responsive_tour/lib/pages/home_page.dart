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
  late Place place;
  String? state;

  @override
  void initState() {
    super.initState();
    place = allPlaces.firstWhere((place) => place.id == widget.placeId, orElse: () => allPlaces.first);
    debugPrint("[_HomePageState] inited place: id='${place.id}' title='${place.title}'.");
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.placeId != widget.placeId) {
      place = allPlaces.firstWhere((place) => place.id == widget.placeId, orElse: () => allPlaces.first);
      debugPrint("[_HomePageState] on didUpdateWidget, updated place: id='${place.id}' title='${place.title}'.");
    }
  }

  void changePlace(Place place) {
    setState(() => this.place = place);
    context.go('/places/${place.id}');
    debugPrint("[_HomePageState] updated place: id='${this.place.id}' title='${this.place.title}'.");
  }

  void changeState(String? state) {
    setState(() {
      this.state = state == this.state ? null : state;
      place = allPlaces.firstWhere((place) => place.state == state);
    });
    debugPrint("[_HomePageState] updated state='$state' and place: id='${place.id}' title='${place.title}'.");
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Tour'), backgroundColor: grayColor),
      drawer: isMobile
          ? Drawer(
              child: DrawerWidget(onStateChanged: changeState, state: state, screenSize: ScreenSize.mobile),
            )
          : null,
      backgroundColor: grayColor,
      body: ResponsiveWidget(mobile: buildMobile(), tablet: buildTablet(), desktop: buildDesktop()),
    );
  }

  Widget buildMobile() => PlaceGalleryWidget(onPlaceChanged: changePlace, state: state);

  Widget buildTablet() => Row(
    children: [
      Expanded(
        flex: 2,
        child: DrawerWidget(onStateChanged: changeState, state: state, screenSize: ScreenSize.tablet),
      ),
      Expanded(
        flex: 5,
        child: PlaceGalleryWidget(onPlaceChanged: changePlace, state: state),
      ),
    ],
  );

  Widget buildDesktop() => Row(
    children: [
      Expanded(
        child: DrawerWidget(onStateChanged: changeState, state: state, screenSize: ScreenSize.desktop),
      ),
      Expanded(flex: 3, child: buildDesktopBody()),
    ],
  );

  Widget buildDesktopBody() => Container(
    color: grayColor,
    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
    child: Column(
      children: [
        Expanded(
          child: PlaceGalleryWidget(onPlaceChanged: changePlace, isHorizontal: true, state: state),
        ),
        Expanded(flex: 2, child: PlaceDetailsWidget(place: place)),
      ],
    ),
  );
}
