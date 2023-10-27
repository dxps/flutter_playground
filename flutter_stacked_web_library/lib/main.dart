import 'package:flutter/material.dart';
import 'package:flutter_stacked_web_library/ui/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_stacked_web_library/app/app.bottomsheets.dart';
import 'package:flutter_stacked_web_library/app/app.dialogs.dart';
import 'package:flutter_stacked_web_library/app/app.locator.dart';
import 'package:flutter_stacked_web_library/app/app.router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await setupLocator(stackedRouter: stackedRouter);
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (_) => MaterialApp.router(
        title: 'Library',
        theme: Theme.of(context).copyWith(
          primaryColor: kcBackgroundColor,
          focusColor: kcPrimaryColor,
          textTheme: GoogleFonts.openSansTextTheme().apply(
            bodyColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: stackedRouter.delegate(),
        routeInformationParser: stackedRouter.defaultRouteParser(),
      ),
    ).animate().fadeIn(
          delay: const Duration(milliseconds: 50),
          duration: const Duration(milliseconds: 400),
        );
  }
}
