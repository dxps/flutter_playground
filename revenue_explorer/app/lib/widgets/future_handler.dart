import 'package:flutter/material.dart';

class RevExFutureHandler<T> extends StatelessWidget {
  final Future<T>? future;
  final String errorText;
  final Widget Function(BuildContext, T) childBuilder;

  const RevExFutureHandler({
    super.key,
    required this.future,
    required this.errorText,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        widgetToShow() {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;
          if (snapshot.hasError || data == null) {
            return Text(errorText);
          }

          return childBuilder(context, data);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeOut,
          child: widgetToShow(),
        );
      },
    );
  }
}
