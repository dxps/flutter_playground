import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_landing/ui/common/styles.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          'MASTER\nFLUTTER',
          style: ktsTitleText,
          colors: const [Color(0xff0CFF60), Color(0xff0091FB)],
        ),
        Text(
          'ON THE WEB',
          style: ktsTitleText,
        ),
      ],
    );
  }
}
