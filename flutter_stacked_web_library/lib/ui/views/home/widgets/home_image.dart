import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/extensions/hover_extensions.dart';
import 'package:flutter_stacked_web_library/ui/common/app_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final width = getValueForScreenType<double>(
      context: context,
      mobile: double.infinity,
      // tablet: kdDesktopMaxContentWidth * 0.4,
      desktop: kdDesktopMaxContentWidth * 0.4,
    );
    final height = getValueForScreenType<double>(
      context: context,
      mobile: 650,
    );

    return GestureDetector(
      // onTap: viewModel.navigateTo...
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/master-web-hero-image.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    ).showCursorOnHover.moveOnHover(y: 4);
  }
}
