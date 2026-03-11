import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';
import 'cubits/images_cubit.dart';
import 'ui/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Not used, but left as reference.
        // BlocProvider(create: (context) => ImagesBloc()),
        BlocProvider(create: (context) => ImagesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blocify Expense Tracker',
        theme: appTheme,
        home: const DashboardScreen(),
      ),
    );
  }
}
