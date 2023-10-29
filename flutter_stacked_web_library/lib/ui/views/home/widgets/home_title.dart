import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/common/shared_styles.dart';
import 'package:flutter_stacked_web_library/ui/common/ui_helpers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: getValueForScreenType(
        context: context,
        mobile: CrossAxisAlignment.center,
        desktop: CrossAxisAlignment.start,
      ),
      children: [
        GradientText(
          'MASTER\nFLUTTER',
          style: ktsTitleText.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 80),
          ),
          colors: const [Color(0xff0CFF60), Color(0xff0091FB)],
        ),
        Text(
          'ON THE WEB',
          style: ktsTitleText.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 70),
          ),
        ),
      ],
    );
  }
}
