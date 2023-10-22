import 'package:flutter_stacked_web_landing/ui/common/academy_icon.dart';
import 'package:flutter_stacked_web_landing/ui/common/app_colors.dart';
import 'package:flutter_stacked_web_landing/ui/common/input_field.dart';
import 'package:flutter_stacked_web_landing/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_landing/ui/views/home/widgets/home_image.dart';
import 'package:flutter_stacked_web_landing/ui/views/home/widgets/home_notify_button.dart';
import 'package:flutter_stacked_web_landing/ui/views/home/widgets/home_subtitle.dart';
import 'package:flutter_stacked_web_landing/ui/views/home/widgets/home_title.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  final TextEditingController? controller;
  const HomeViewMobile({super.key, this.controller});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
        backgroundColor: kcBackgroundColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 50,
          ),
          children: [
            const AcademyIcon(),
            verticalSpaceLarge,
            const HomeTitle(),
            verticalSpaceTiny,
            const HomeSubtitle(),
            verticalSpaceLarge,
            InputField(controller: controller),
            verticalSpaceMedium,
            HomeNotifyButton(
              onTap: viewModel.captureEmail,
            ),
            verticalSpaceMedium,
            const HomeImage(),
          ],
        ));
  }
}
