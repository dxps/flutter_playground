import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/counter/counter_bloc_bloc.dart';

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBlocBloc>(
      create: (context) => CounterBlocBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<CounterBlocBloc, CounterBlocState>(
              listener: (context, state) async {
                // This presentation logic is the same as in the cubit screen.
                if (state.counter == 3) {
                  debugPrint(">>> [CounterBlocScreen] Counter is 3!");
                  final navigator = Navigator.of(context, rootNavigator: true);

                  showDialog<void>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          "[info]",
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          "The counter is ${state.counter}!\n\nMake the counter -1 and\nyou'll get a surprise screen.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );

                  await Future.delayed(const Duration(seconds: 3));

                  if (navigator.mounted && navigator.canPop()) {
                    navigator.pop();
                  }
                } else if (state.counter == -1) {
                  if (context.mounted) {
                    context.push('/surprise');
                  }
                }
              },
              child: Center(
                child: Text(
                  "${context.watch<CounterBlocBloc>().state.counter}",
                  style: TextStyle(fontSize: 80, color: Colors.blueGrey[200]),
                ),
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green[800],
                  shape: const CircleBorder(),
                  tooltip: "Increment",
                  heroTag: null,
                  onPressed: () {
                    BlocProvider.of<CounterBlocBloc>(context).add(IncrementCounterEvent());
                  },
                  child: const Icon(Icons.add, size: 16),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange[900],
                  shape: const CircleBorder(),
                  tooltip: "Decrement",
                  heroTag: null,
                  onPressed: () {
                    // BlocProvider.of<CounterBlocBloc>(context).add(DecrementCounterEvent());
                    // A cleaner syntax.
                    context.read<CounterBlocBloc>().add(DecrementCounterEvent());
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
