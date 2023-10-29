import 'package:flutter_stacked_web_library/ui/common/app_colors.dart';
import 'package:flutter_stacked_web_library/ui/common/app_constants.dart';
import 'package:flutter_stacked_web_library/ui/common/shared_styles.dart';
import 'package:flutter_stacked_web_library/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_image.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_subtitle.dart';
import 'package:flutter_stacked_web_library/ui/views/home/widgets/home_title.dart';
import 'package:flutter_stacked_web_library/ui/widgets/common/google_sign_in.dart';
import 'package:flutter_stacked_web_library/ui/widgets/common/library_icon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: SizedBox(
          width: kdDesktopMaxContentWidth,
          height: kdDesktopMaxContentHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // The left side of the screen.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LibraryIcon(),
                  const Spacer(flex: 2),
                  const HomeTitle(),
                  const HomeSubtitle(),
                  verticalSpaceMedium,
                  // Arrow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: SvgPicture.asset('assets/sign-up-arrow.svg'),
                  ),
                  verticalSpaceSmall,
                  const GoogleSignIn(),
                  const Spacer(flex: 3)
                ],
              ),
              // The right side of the screen.
              const HomeImage(),
            ],
          ),
        ),
      ),
    );
  }
}
