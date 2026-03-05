import 'package:flutter/material.dart';
import 'package:responsive_tour/data/places.dart';
import 'package:responsive_tour/widgets/grid_item_widget.dart';

class PlaceGalleryWidget extends StatelessWidget {
  const PlaceGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.grey[200],
    child: GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1 / 1.2,
      children: allPlaces
          .map<Widget>((place) => GridItemWidget(place: place))
          .toList(),
    ),
  );
}
