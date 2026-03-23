import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/images_cubit.dart';
import 'screens/images_screen.dart';

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
        title: 'Blocify',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const ImagesScreen(),
      ),
    );
  }
}
