import 'package:momentum/momentum.dart';
import './counter_model.dart';

/// The Controller, where logic is implemented.
///
class CounterController extends MomentumController<CounterModel> {
  //
  @override
  CounterModel init() {
    return CounterModel(this, value: 0);
  }

  void increment() {
    var value = model.value; // get the current value
    model.update(value: value + 1); // update the state with the new value (=> widgets rebuild)
    print(">>> CounterController > increment > value=${model.value}");
  }
}
