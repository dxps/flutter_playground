part of 'counter_bloc_bloc.dart';

class CounterBlocState extends Equatable {
  final int counter;

  const CounterBlocState({required this.counter});

  factory CounterBlocState.initial() => const CounterBlocState(counter: 0);

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterBlocState(counter: $counter)';

  CounterBlocState copyWith({
    int? counter,
  }) => CounterBlocState(counter: counter ?? this.counter);
}
