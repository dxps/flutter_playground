import 'package:counters_bloc_cubit/blocs/counter/counter_bloc_bloc.dart';
import 'package:counters_bloc_cubit/cubits/counter/counter_cubit.dart';
import 'package:counters_bloc_cubit/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}

const darkBg = Color(0xFF3d3d3d);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
      ),
      BlocProvider<CounterBlocBloc>(
        create: (context) => CounterBlocBloc(),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      darkTheme:
          ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey,
              brightness: Brightness.dark,
            ),
          ).copyWith(
            scaffoldBackgroundColor: darkBg,
            canvasColor: darkBg,
          ),
      themeMode: ThemeMode.dark,
    ),
  );
}
