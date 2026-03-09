import 'package:flutter/material.dart';
import 'package:responsive_tour/consts.dart';

import '../data/places.dart';
import '../model/place.dart';
import 'gallery_item_widget.dart';

class PlaceGalleryWidget extends StatelessWidget {
  final String? state;
  final ValueChanged<Place> onPlaceChanged;
  final bool isHorizontal;

  const PlaceGalleryWidget({super.key, required this.onPlaceChanged, this.state, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    final placesGrid = allPlaces
        .where((place) => state == null || place.state == state)
        .map((place) => GalleryItemWidget(place: place, onPlaceChanged: onPlaceChanged))
        .toList();

    debugPrint("[PlaceGalleryWidget] since state=$state, placesGrid.length=${placesGrid.length}");

    return Container(
      color: grayColor,
      child: GridView.count(
        crossAxisCount: isHorizontal ? 1 : 2,
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: isHorizontal ? const EdgeInsets.only(left: 8, right: 8, bottom: 8) : const EdgeInsets.all(8),
        childAspectRatio: 1 / 1.2,
        children: placesGrid,
      ),
    );
  }
}
