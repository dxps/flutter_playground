import 'package:flutter/material.dart';

/// `StateModel` is the base class for (to be extended by)
/// all the custom (app specific) states used within the application.
/// It is a node in a state dependencies graph.
class StateModel extends State {
  //

  /// A map of stateIDs and respective states that are subscribed
  /// to get updates notifications from this state.
  Map<String, State> _outs = {};

  /// Subcribe to get notified on updates from this state node.
  void subscribe(String stateId, State s) => _outs[stateId] = s;

  /// Unsubcribe from geting notified on updates from this state node.
  void unsubscribe(String stateId, int stateHashCode) {
    if (_outs[stateId].hashCode == stateHashCode) {
      _outs.remove(stateId);
    }
  }

  /// Updates the state dependencies graph: this state and all the subscribed ones.
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
