import 'package:flutter_stacked_web_library/ui/common/app_colors.dart';
import 'package:flutter_stacked_web_library/ui/common/app_constants.dart';
import 'package:flutter_stacked_web_library/ui/common/shared_styles.dart';
import 'package:flutter_stacked_web_library/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
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
                  // Academy Icon
                  Text(
                    'FilledStacks Academy',
                    style: ktsBodyRegular.copyWith(fontWeight: FontWeight.w800),
                  ),

                  // Space
                  const Spacer(flex: 2),

                  // Title
                  GradientText(
                    'MASTER\nFLUTTER',
                    style: ktsTitleText,
                    colors: const [Color(0xff0CFF60), Color(0xff0091FB)],
                  ),
                  Text(
                    'ON THE WEB',
                    style: ktsTitleText,
                  ),

                  // Subtitle
                  Row(
                    children: [
                      Text(
                        'Build amazing software, the right way.',
                        style: ktsBodyLarge.copyWith(fontWeight: FontWeight.w600),
                      ),
                      GradientText(
                        ' Sign up to be notified',
                        style: ktsBodyLarge.copyWith(fontWeight: FontWeight.w600),
                        colors: const [Color(0xff0CFF60), Color(0xff0091FB)],
                      )
                    ],
                  ),

                  verticalSpaceMedium,

                  // Arrow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: SvgPicture.asset('assets/sign-up-arrow.svg'),
                  ),

                  verticalSpaceSmall,

                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: const Text(
                      'Sign up with Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const Spacer(flex: 3)
                ],
              ),
              // The right side of the screen.
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/master-web-hero-image.png',
                  width: kdDesktopMaxContentWidth * 0.4,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
