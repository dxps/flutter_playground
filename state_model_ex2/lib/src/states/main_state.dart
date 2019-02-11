import 'package:flutter/widgets.dart'; // for using `State`
import 'dart:math';
import './state_model.dart';
export './state_model.dart';

/// The main state.
class MainState extends StateModel {
  //

  final String stateId = "MainState";

  List<int> items = [];
  bool isLoadingItems = true;

  /// Fetch the list of items.
  Future<void> fetchList({State state, String stateId}) async {
    //
    isLoadingItems = true;
    if (state != null) updateStates(states: [state]);
    if (stateId != null) updateStates(ids: [stateId]);
    items = await Future.delayed(
      Duration(seconds: 2),
      () => List<int>.generate(10, (_) => Random().nextInt(9) + 1),
    );
    isLoadingItems = false;
    if (state != null) updateStates(states: [state]);
    if (stateId != null) updateStates(ids: [stateId]);
    //
  }

  /// Decrement the value of item stored at provided index.
  void decrement(int index, state) {
    //
    items[index]--;
    if (items[index] > 0) {
      updateStates(states: [state]);
    } else {
      items.removeAt(index);
      updateStates(ids: [stateId]);
    }
  }

  //
}

MainState mainState; // declared here, instantiated in runApp(_)
