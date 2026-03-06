import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_tour/model/place.dart';
import 'package:responsive_tour/pages/details_page.dart';
import 'package:responsive_tour/widgets/responsive_widget.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({
    required this.place,
    required this.onPlaceChanged,
    super.key,
  });

  final Place place;
  final ValueChanged<Place> onPlaceChanged;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.025;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          final isMobile = ResponsiveWidget.isMobile(context);
          final isTablet = ResponsiveWidget.isTablet(context);

          if (isMobile || isTablet) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsPage(place: place),
              ),
            );
          } else {
            onPlaceChanged(place);
          }
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: AutoSizeText(
              place.title,
              minFontSize: 18,
              maxFontSize: 28,
              style: TextStyle(fontSize: fontSize),
            ),
            subtitle: AutoSizeText(
              place.subtitle,
              minFontSize: 14,
              maxFontSize: 20,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
          child: Ink.image(image: AssetImage(place.image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
