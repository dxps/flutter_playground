import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_landing/ui/common/styles.dart';

class AcademyIcon extends StatelessWidget {
  const AcademyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FilledStacks Academy',
      style: ktsBodyRegular.copyWith(fontWeight: FontWeight.w800),
    );
  }
}
