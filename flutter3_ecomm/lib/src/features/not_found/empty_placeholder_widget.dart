import 'package:flutter3_ecomm/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_ecomm/src/common_widgets/primary_button.dart';
import 'package:flutter3_ecomm/src/constants/app_sizes.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
