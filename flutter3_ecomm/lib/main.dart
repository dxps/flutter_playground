import 'dart:async';

import 'package:flutter3_ecomm/src/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // For more info on error handling, see:
  // https://docs.flutter.dev/testing/errors
  await runZonedGuarded(() async {
    // Entry point of the app
    runApp(const MyApp());

    // This code will present some error UI if any uncaught exception happens.
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }, (Object error, StackTrace stack) {
    // Log any errors to console.
    debugPrint(error.toString());
  });
}
