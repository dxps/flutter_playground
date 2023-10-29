import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/common/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/master-web-hero-image.png',
        width: kdDesktopMaxContentWidth * 0.4,
        height: getValueForScreenType<double>(context: context, mobile: 650, desktop: double.infinity),
        fit: BoxFit.cover,
      ),
    );
  }
}
