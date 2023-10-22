import 'package:flutter_stacked_web_landing/extensions/hover_extensions.dart';
import 'package:flutter_stacked_web_landing/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_landing/ui/common/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeSubtitle extends StatelessWidget {
  const HomeSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      Text(
        'Build amazing software, the right way.',
        style: ktsBodyLarge.copyWith(fontWeight: FontWeight.w600),
      ),
      GradientText(
        ' Sign up to be notified',
        style: ktsBodyLarge.copyWith(fontWeight: FontWeight.w600),
        colors: kgTitle,
      ).scaleOnHover().moveOnHover(y: 5),
    ];

    return ScreenTypeLayout.builder(
      mobile: (_) => Column(children: children),
      tablet: (_) => Row(children: children),
      desktop: (_) => Row(children: children),
    );
  }
}
