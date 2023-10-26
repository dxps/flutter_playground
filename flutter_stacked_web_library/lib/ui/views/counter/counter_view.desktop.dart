import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'counter_viewmodel.dart';

class CounterViewDesktop extends ViewModelWidget<CounterViewModel> {
  const CounterViewDesktop({super.key});

  @override
  Widget build(BuildContext context, CounterViewModel viewModel) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: viewModel.incrementCounter),
      body: Center(
        child: Text(
          viewModel.counter.toString(),
          style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ),
    );
  }
}
