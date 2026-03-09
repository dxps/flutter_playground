import 'package:flutter/material.dart';

import '../data/places.dart';
import '../model/place.dart';
import '../widgets/grid_item_widget.dart';

class PlaceGalleryWidget extends StatelessWidget {
  final String? state;
  final ValueChanged<Place> onPlaceChanged;
  final bool isHorizontal;

  const PlaceGalleryWidget({super.key, required this.onPlaceChanged, this.state, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    final placesGrid = allPlaces
        .where((place) => state == null || place.state == state)
        .map((place) => GridItemWidget(place: place, onPlaceChanged: onPlaceChanged))
        .toList();

    debugPrint("[PlaceGalleryWidget] since state=$state, placesGrid.length=${placesGrid.length}");

    return Container(
      color: Colors.grey[200],
      child: GridView.count(
        crossAxisCount: isHorizontal ? 1 : 2,
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1 / 1.2,
        children: placesGrid,
      ),
    );
  }
}
