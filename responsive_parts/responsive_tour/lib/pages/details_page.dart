import 'package:flutter/material.dart';
import 'package:responsive_tour/consts.dart';

import '../model/place.dart';
import '../widgets/place_details_widget.dart';

class DetailsPage extends StatelessWidget {
  final Place place;

  const DetailsPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: grayColor,
    appBar: AppBar(
      title: Text(place.subtitle),
      centerTitle: true,
      backgroundColor: grayColor,
    ),
    body: PlaceDetailsWidget(place: place),
  );
}
