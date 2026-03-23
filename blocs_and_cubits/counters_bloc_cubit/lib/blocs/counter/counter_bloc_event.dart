part of 'counter_bloc_bloc.dart';

sealed class CounterBlocEvent extends Equatable {
  const CounterBlocEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounterEvent extends CounterBlocEvent {}

class DecrementCounterEvent extends CounterBlocEvent {}
