import 'package:flutter/material.dart';

import '../model/place.dart';
import '../widgets/place_details_widget.dart';

class DetailsPage extends StatelessWidget {
  final Place place;

  const DetailsPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(place.subtitle), centerTitle: true),
    body: PlaceDetailsWidget(place: place),
  );
}
