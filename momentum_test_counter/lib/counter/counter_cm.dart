///
/// Counter > Controller & Model
///

import 'package:momentum/momentum.dart';
export 'package:momentum/momentum.dart';

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

class CounterModel extends MomentumModel<CounterController> {
  //
  CounterModel(CounterController controller, {this.value}) : super(controller);

  final int value;

  @override
  void update({int value}) {
    CounterModel(controller, value: value ?? this.value).updateMomentum();
  }
}
