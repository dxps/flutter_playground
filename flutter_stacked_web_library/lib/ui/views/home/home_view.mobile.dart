import 'package:flutter_stacked_web_library/ui/common/app_colors.dart';
import 'package:flutter_stacked_web_library/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_image.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_subtitle.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_title.dart';
import 'package:flutter_stacked_web_library/ui/widgets/common/google_sign_in.dart';
import 'package:flutter_stacked_web_library/ui/widgets/common/library_icon.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        children: const [
          LibraryIcon(),
          verticalSpaceLarge,
          HomeTitle(),
          verticalSpaceTiny,
          HomeSubtitle(),
          verticalSpaceLarge,
          GoogleSignIn(),
          verticalSpaceMedium,
          HomeImage(),
        ],
      ),
    );
  }
}
