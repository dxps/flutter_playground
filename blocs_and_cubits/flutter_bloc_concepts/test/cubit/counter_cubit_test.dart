import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:test/test.dart';

void main() {
  group("CounterCubit", () {
    late CounterCubit counterCubit;

    setUp(() {
      // Initializing the testing scene.
      counterCubit = CounterCubit();
    });

    tearDown(() {
      // Shutdown and cleanup.
      counterCubit.close();
    });

    test("Initial state is CounterState(counterValue:0)", () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });

    blocTest<CounterCubit, CounterState>(
      "cubit.increment() test",
      // The build function returns the current instance to be used during this test.
      build: () => counterCubit,
      // The act function includes the actions whose result is evaluated.
      act: (cubit) => cubit.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, CounterState>(
      "cubit.decrement() test",
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
