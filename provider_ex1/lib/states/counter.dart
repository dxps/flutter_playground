import 'package:flutter/material.dart';

///
/// The counter model.
///
class Counter with ChangeNotifier {
  //

  int _counter;

  Counter(this._counter);

  getValue() => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  //
}
