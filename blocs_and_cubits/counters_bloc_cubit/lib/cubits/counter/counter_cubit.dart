import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'counter_cubit_state.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit() : super(CounterCubitState.initial());

  void increment() {
    final newState = state.copyWith(counter: state.counter + 1);
    debugPrint(">>> CounterCubit incremented: ${newState.counter}");
    emit(newState);
  }

  void decrement() {
    final newState = state.copyWith(counter: state.counter - 1);
    debugPrint(">>> CounterCubit decremented: ${newState.counter}");
    emit(newState);
  }
}
