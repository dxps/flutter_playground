import 'package:flutter/material.dart';

/// The base class for (to be extended by) all the State Mgmt Components (SMC).
class BaseSmc extends State {
  //

  /// A map of stateIDs and respective states.
  Map<String, State> _statesMap = {};

  void rebuildStates({VoidCallback setStateFn, List<State> states, List<String> ids}) {
    //
    if (states != null) {
      states.forEach((s) {
        if (s != null && s.mounted) s.setState(setStateFn ?? () {});
      });
    }
    if (ids != null) {
      ids.forEach((id) {
        final State s = _statesMap[id];
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

///
class StateBuilder extends StatefulWidget {
  //

  @required
  final Widget Function(State state) builder;

  final void Function(State state) initState, dispose, didChangeDependencies;

  final void Function(StateBuilder oldWidget, State state) didUpdateWidget;

  /// The ID of the state.
  final String stateID;

  /// The list of SMCs.
  final List<BaseSmc> smcs;

  const StateBuilder(
      {Key key,
      this.stateID,
      this.builder,
      this.initState,
      this.dispose,
      this.didChangeDependencies,
      this.didUpdateWidget,
      this.smcs})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateBuilderState();

  //
}

///
class _StateBuilderState extends State<StateBuilder> {
  //

  @override
  void initState() {
    //
    super.initState();
    if (widget.stateID != null && widget.stateID != "") {
      if (widget.smcs != null) {
        widget.smcs.forEach(
          (smc) {
            if (smc == null) return;
            smc._statesMap[widget.stateID] = this;
          },
        );
      }
    }

    if (widget.initState != null) widget.initState(this);
  }

  @override
  void dispose() {
    if (widget.stateID != null && widget.stateID != "") {
      if (widget.smcs != null) {
        widget.smcs.forEach(
          (smc) {
            if (smc == null) return;
            if (smc._statesMap[widget.stateID].hashCode == this.hashCode) {
              smc._statesMap.remove(widget.stateID);
            }
          },
        );
      }
    }

    if (widget.dispose != null) widget.dispose(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.didChangeDependencies != null) widget.didChangeDependencies(this);
  }

  @override
  void didUpdateWidget(StateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.didUpdateWidget != null) widget.didUpdateWidget(oldWidget, this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }

  //
}
