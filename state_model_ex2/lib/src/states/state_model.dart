import 'package:flutter/material.dart';
export 'state_builder.dart';

///
/// `StateModel` is the base class for (to be extended by)
/// all the custom (app or domain specific) states
/// used within the application.
///
class StateModel extends State {
  //

  /// A map of stateIDs and respective states that are subscribed
  /// to get notified on this state updates.
  Map<String, State> _outs = {};

  /// Subcribe to get notified on this state updates.
  void subscribe(String stateId, State s) => _outs[stateId] = s;

  /// Unsubcribe from geting notified on updates from this state node.
  void unsubscribe(String stateId, int stateHashCode) {
    if (_outs[stateId].hashCode == stateHashCode) {
      _outs.remove(stateId);
    }
  }

  /// Updates the state dependencies chain: the provided states and/or
  /// the subscribed ones based on the provided ids.
  void updateStates({VoidCallback setStateFn, List<State> states, List<String> ids}) {
    //
    if (states != null) {
      states.forEach((s) {
        if (s != null && s.mounted) s.setState(setStateFn ?? () {});
      });
    }
    if (ids != null) {
      ids.forEach((id) {
        final State s = _outs[id];
        if (s != null && s.mounted) s.setState(setStateFn ?? () {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nothing to do here. It will never be called.
    return null;
  }

  //
}
