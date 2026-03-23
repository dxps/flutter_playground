import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/counter/counter_cubit.dart';

class CounterCubitScreen extends StatelessWidget {
  const CounterCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterCubitState>(
        listener: (context, state) async {
          if (state.counter == 3) {
            final navigator = Navigator.of(context, rootNavigator: true);

            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  title: Text(
                    "[info]",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    "The (cubit based) counter is ${state.counter}.\n\nMake the counter -1 and\nyou'll get a surprise screen.",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );

            await Future.delayed(const Duration(seconds: 2));

            if (navigator.mounted && navigator.canPop()) {
              navigator.pop();
            }
          } else if (state.counter == -1) {
            if (context.mounted) {
              context.push('/surprise');
            }
          }
        },
        builder: (context, state) {
          return Center(
            child: Text(
              "${state.counter}",
              style: TextStyle(fontSize: 80, color: Colors.blueGrey[200]),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepOrange[900],
            shape: const CircleBorder(),
            tooltip: "Decrement",
            heroTag: null,
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            backgroundColor: Colors.green[800],
            shape: const CircleBorder(),
            tooltip: "Increment",
            heroTag: null,
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add, size: 16),
          ),
        ],
      ),
    );
  }
}
