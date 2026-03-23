part of 'counter_cubit.dart';

class CounterCubitState extends Equatable {
  final int counter;

  const CounterCubitState({required this.counter});

  factory CounterCubitState.initial() => const CounterCubitState(counter: 0);

  @override
  List<Object?> get props => [counter];

  @override
  String toString() => 'CounterCubitState(counter: $counter)';

  CounterCubitState copyWith({
    int? counter,
  }) => CounterCubitState(counter: counter ?? this.counter);
}
