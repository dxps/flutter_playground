import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:revenue_explorer/preferences/first_usage_date.dart';
import 'package:revenue_explorer/router.dart';
import 'package:revenue_explorer/theme.dart';
import 'package:revenue_explorer/transactions.state.dart';
import 'package:revenue_explorer/user.state.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RevExUserState()),
        ChangeNotifierProvider(create: (context) => RevExTransactionsState())
      ],
      child: ThemeProvider(
        defaultThemeId: revexLightTheme.appTheme.id,
        themes: [
          revexLightTheme.appTheme,
          AppTheme.dark(),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp.router(
              scrollBehavior:
                  const MaterialScrollBehavior().copyWith(scrollbars: false),
              debugShowCheckedModeBanner: false,
              title: 'Revenue Explorer',
              theme: ThemeProvider.themeOf(themeContext).data,
              routeInformationParser: revexRouter.routeInformationParser,
              routeInformationProvider: revexRouter.routeInformationProvider,
              routerDelegate: revexRouter.routerDelegate,
            ),
          ),
        ),
      ),
    );
  }
}

class RevExScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final Future<DateTime> firstUsageDate;

  RevExScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  }) : firstUsageDate = revexGetFirstUsageDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.push('/profile');
            },
            icon: const Icon(Icons.account_circle),
            tooltip: 'My Profile',
          ),
        ],
        centerTitle: true,
        title: Text(title),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
