import 'package:momentum/momentum.dart';

import 'counter_controller.dart';

/// The Model, where the state exists.
///
class CounterModel extends MomentumModel<CounterController> {
  //
  CounterModel(CounterController controller, {this.value}) : super(controller);

  final int value;

  @override
  void update({int value}) {
    CounterModel(controller, value: value ?? this.value).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  CounterModel fromJson(Map<String, dynamic> json) {
    return CounterModel(controller, value: json['value']);
  }
}
