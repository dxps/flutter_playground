import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/image_bloc/images_bloc.dart';
import 'screens/load_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blocify',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const LoadImageScreen(),
      ),
    );
  }
}
