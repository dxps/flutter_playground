import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/common/shared_styles.dart';

class LibraryIcon extends StatelessWidget {
  const LibraryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Library',
      style: ktsBodyRegular.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
